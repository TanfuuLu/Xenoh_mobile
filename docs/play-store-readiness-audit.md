# Google Play Readiness Audit — Xenoh Mobile

Audited on branch `codex/mobile-social-login`, Flutter 3.44.8 / Dart 3.12.2.
Verified by reading configuration and source, and by producing a real signed
release bundle. This supersedes the "Completed" claims in
`docs/google-play-implementation-plan.md`, which no longer match the code.

## Verdict

The Android build is in good shape. The payment blocker **has now been fixed**
in this repo (see §2 B1). What remains is off-repo: the Play Console track and
verification of the public web pages.

**Monetisation model (decided):** subscriptions are sold on the Xenoh website
only. The mobile client observes entitlement state and never sells, activates,
or links to a purchase.

---

## 1. What was verified as passing

| Check | Result | Evidence |
|---|---|---|
| Release AAB builds | Pass — 75.3 MB | `flutter build appbundle --release` exit 0 |
| Upload signing | Pass — real Xenoh key, not debug | `CN=Phuc Lu, O=Xenoh, C=VN`, valid to 2053-12-15, SHA1 `88:B4:…:1D:45` |
| Signing fails loudly if misconfigured | Pass | `android/app/build.gradle.kts` throws on missing `key.properties` for release tasks |
| `key.properties` kept out of git | Pass | ignored via `android/.gitignore:12`, not tracked |
| targetSdk / compileSdk | Pass — 36 / 36 (Play floor is 35) | merged release manifest |
| minSdk | 24 | merged release manifest |
| Permissions minimal & justifiable | Pass | INTERNET, ACCESS_NETWORK_STATE, FOREGROUND_SERVICE(+DATA_SYNC), POST_NOTIFICATIONS, WAKE_LOCK, RECEIVE_BOOT_COMPLETED — all traceable to the workout notification or networking |
| No cleartext traffic, no debuggable flag | Pass | absent from merged manifest |
| TLS bypass impossible in release | Pass | `AppConfig.allowBadCertificate` requires `kDebugMode && isLocalhost` |
| API base URL fails safe in release | Pass | defaults to `https://api.xenoh.online/api` |
| Static analysis | Pass — "No issues found" | `flutter analyze` |
| Test suite | Pass — 340 tests | `flutter test` |
| Launcher icon + adaptive icon + splash | Pass | `mipmap-anydpi-v26/ic_launcher.xml`, night variants, `flutter_native_splash.yaml` |
| In-app account deletion | Pass, and localized | `account_deletion_request_screen.dart`, `accountDeletionSettingsLabel` in both `app_en.arb`/`app_vi.arb` |
| Public unauthenticated legal routes | Pass | `/privacy`, `/terms`, `/refund-policy`, `/account-deletion` all in `isPublicLocation` |
| UGC report/block surface | Present | `features/blocks_reports`, `/settings/blocklist`, `/admin/moderation` |
| Admin surfaces gated | Pass client-side | `routeAccessRedirect` bounces non-admins off `/admin*` |
| Notification runtime permission requested | Pass | `workout_notification_service_io.dart:85` |

---

## 2. Blockers

### B1 — In-app bank-transfer payment flow — **RESOLVED**

The flow was live despite `google-play-implementation-plan.md` claiming
otherwise: `/subscription` mounted a checkout that listed VND prices, validated
promotion codes, called `POST /subscriptions/payment-orders`, and displayed
bank name, account number, amount, and a copyable transfer code. That is
in-app digital-content purchase outside Google Play Billing — a Payments-policy
rejection.

Removed, per the website-only decision:

- Deleted `presentation/widgets/subscription_checkout_section.dart` and
  `domain/entities/billing.dart` (`SubscriptionCatalog`, `SubscriptionOffer`,
  `PromotionValidation`, `CreatePaymentOrderInput`, `PaymentOrder`).
- `SubscriptionRemoteDataSource` now exposes only `getMySubscription()`;
  `getCatalog`, `validatePromotion`, and `createPaymentOrder` are gone from the
  data source, the repository, and the repository interface.
- Dropped `subscriptionCatalogProvider`.
- `SubscriptionStatusScreen` renders tier, expiry, and AI quota only.
- Removed 27 payment/promotion/checkout l10n keys from `app_en.arb` and
  `app_vi.arb` and regenerated. `subscriptionMonthsLabel` was kept — admin
  tooling still uses it.
- Deleted the three payment test files; added
  `test/features/subscription/subscription_no_payment_test.dart`, which fails
  if a purchase surface returns: it asserts the screen has no text field,
  checkbox, or submit button, that no non-admin source file references the
  purchase endpoints, and that the repository interface has no purchase method.

Note there is deliberately **no** "subscribe on our website" link or copy —
payment steering is itself a violation outside an approved regional program.

### B2 — Live public web pages not confirmed

Play will not approve without a reachable, non-PDF privacy policy URL, and the
Data-deletion declaration needs a public deletion page. The in-app `/privacy`
and `/account-deletion` routes exist but Play needs **web** URLs
(`https://xenoh.online/privacy`, `https://xenoh.online/account-deletion`).
Neither was verified reachable in this audit — someone must load them in a
browser and confirm they are public, not behind login, and describe exactly
what the Data Safety form will declare.

### B3 — Backend deletion endpoints — confirmed to exist, still need an end-to-end run

The backend implements account deletion, so the contract is satisfied. What is
still worth doing once, because Play exercises it during review: run
`DELETE /users/me` against production with a throwaway account and confirm the
session cannot refresh afterwards, and run the email-based
`POST /auth/account-deletion-requests` + verify pair. This is a smoke test, not
a build task.

### B4 — Play Console track entirely unstarted

Nothing in the repo is Console work, but it is on the critical path: Data
Safety, Content Rating, Target Audience, Ads declaration, App Access reviewer
credentials, store listing assets, and — for a new personal developer account
— **12 testers opted in continuously for 14 days** before production access is
granted. That 14-day clock should start as early as possible; it is likely the
longest pole.

---

## 3. Risks and things to decide

| # | Item | Why it matters |
|---|---|---|
| R1 | Foreground-service declaration | `FOREGROUND_SERVICE_DATA_SYNC` requires a Console declaration form with a video demo of the workout notification and a justification. `dataSync` is also a scrutinised type — be ready to argue why the ongoing workout notification needs it, or narrow the use. |
| R2 | Sensitive health data | The app has menstrual-cycle tracking (`features/cycle`), nutrition, bodyweight, DOB and gender. Data Safety must declare "Health and fitness" and personal identifiers, and the privacy policy text must match answer-for-answer. Mismatch is a common rejection cause. |
| R3 | AI features | AI coach chat and AI insights. Play's Generative-AI policy requires an in-app way to report offensive AI output. Confirm the existing report flow covers AI responses, not just community posts. |
| R4 | Admin screens in the shipped build | `/admin/payments`, `/admin/finance`, `/admin/promotions` ship in the AAB. Fine if the reviewer account is a plain user — but do not hand reviewers an admin account, or they will see payment-order administration in an app declared to have no payments. |
| R5 | Version numbers | Currently `0.1.0+1`. Decide the public 1.0.0 story before first upload; `versionCode` can never be reused. |
| R6 | UGC policy pack | Public community + direct messages means Play expects in-app reporting, blocking, a moderation commitment, and Terms acceptance before posting. The pieces exist; nobody has confirmed each path end-to-end. |
| R7 | 16 KB page-size compliance | Required for new apps on targetSdk 35+. Flutter 3.44's engine should comply, but Play rejects at upload if any bundled `.so` is not 16 KB-aligned — the internal-testing upload is the cheap way to find out. |
| R8 | Keystore survivability | The upload key exists and is correct, but this audit cannot verify an off-machine backup or Play App Signing enrolment. Losing it before enrolment means never updating the app under this package name. |
| R9 | Competition entry fees | `features/competitions` still has bank-account fields, an expected fee, and a receipt upload for event registration. Play exempts payment for **physical/real-world** goods and services, which event registration is — so this is allowed, but the listing and the screens must read unmistakably as registration for a real-world event, not as unlocking app content. |
| R10 | Plugin KGP deprecation | Build warns that `emoji_picker_flutter`, `file_picker`, `flutter_foreground_task`, `flutter_web_auth_2` apply the Kotlin Gradle Plugin, which future Flutter will reject. Not a Play issue — a future-build issue. |

---

## 4. Discovery plan

Ordered so the long-lead items start first and the expensive rework decision is
made before anyone builds on top of it.

### Step 0 — Monetisation model — **done**

Website-only. Implemented and locked in by test; see B1.

### Step 1 — Start the 14-day tester clock (do this first)

Create the Play Console app with package `online.xenoh.xenoh_mobile`, enrol in
Play App Signing, upload the current AAB to **internal** testing purely to
validate upload mechanics (signature acceptance, 16 KB alignment, target SDK),
and open the closed test so the 12-tester / 14-day requirement starts running.
Do not submit for review yet.

### Step 2 — Code remediation — **done**

Checkout removed, dead payment code and l10n stripped, guard test added.
`flutter analyze` clean, 335 tests pass, release AAB rebuilds. Remaining:
decide and bump the public version (currently `0.1.0+1`).

### Step 2b — Entitlement propagation — **done (mobile side)**

Because the website is now the only path to Pro, the mobile side was hardened
against that chain going stale or drifting:

- **Refresh on resume.** `subscriptionProvider` is kept alive for the whole
  session by the home shell (organizer nav watches it via
  `isOrganizerProvider`), so it never refetched on its own — a user who
  subscribed in their browser and switched back kept seeing the old tier until
  they force-quit. `app.dart` now invalidates it on `AppLifecycleState.resumed`.
- **Refresh on login** was already covered: login invalidates `dioProvider`,
  which `subscriptionRepositoryProvider` watches, so the cascade refetches.
- **Tier matching hardened.** `isPro` / `isProCoach` / `isOrganizer` and
  `tierLabel` now match case- and whitespace-insensitively. Previously an exact
  match meant a casing change on the server would silently show a paying
  customer as Free, with no error anywhere.
- **Removed `isProProvider`** — it had no consumers. Pro access is enforced
  server-side via 403s (`aiGate`); a client-side mirror would be a second
  source of truth that disagrees whenever the cache is stale.
- **Explicit Refresh button** on the subscription screen. Pull-to-refresh alone
  was not discoverable for a user whose plan just changed. Deliberately says
  nothing about where a plan is bought.
- **Contract test** (`subscription_entitlement_test.dart`) pins the
  `GET /subscriptions/me` response shape and the tier strings, so a backend
  rename breaks CI instead of stranding customers.

### Step 3 — Backend and web verification

- Confirm a website purchase flips `GET /subscriptions/me` to Pro on mobile —
  **the highest-value check now**, since the app has no other path to Pro.
  Include the buy-while-app-is-backgrounded sequence, which the resume
  invalidation above is meant to cover.
- Smoke-test the deletion endpoints in production (see B3).
- Load `https://xenoh.online/privacy` and `/account-deletion` in an incognito
  browser; confirm public reachability and that the policy text enumerates
  every data class the app actually collects.

### Step 4 — Device test matrix

Install the release AAB (via internal testing) on physical devices and walk:
register → verify → login (email + each social provider) → onboarding → start a
workout → confirm the ongoing notification → log nutrition → community post +
report + block → coach chat with an image attachment → subscription screen →
settings → delete account. Cover at minimum Android 10, 13 (notification
permission prompt), and 15/16 (edge-to-edge, foreground-service restrictions).
Note anything that crashes, blocks with a permission dialog, or shows English
in a Vietnamese session.

### Step 5 — Console content pass

Data Safety (matched line-by-line to the deployed privacy policy), Content
Rating, Target Audience (declare 18+ or handle the families policy — the app
collects DOB and health data), Ads = none, App Access with a **non-admin**
reviewer account plus written steps for every gated flow, the foreground-service
declaration with video, store listing copy, screenshots, feature graphic, icon.

### Step 6 — Release gate

Ship to production only when every one of these is true:

- [ ] Zero payment or payment-steering content in the release AAB
- [ ] Privacy policy and account-deletion pages live and matching Data Safety
- [ ] Deletion endpoints smoke-tested in production
- [ ] A website purchase confirmed to grant Pro in the mobile app
- [ ] AAB signed by the Xenoh upload key, enrolled in Play App Signing, key backed up off-machine
- [ ] Foreground-service declaration accepted
- [ ] Reviewer account works for every gated flow
- [ ] Closed testing complete (12 testers × 14 days) with no crashes
- [ ] Pre-launch report clean
