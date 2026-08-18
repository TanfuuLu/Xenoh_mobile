# Xenoh Google Play Implementation Plan

> **Status note (2026-08-16):** parts of the "Completed" claims below were
> stale — the bank-transfer checkout was still live in the app until it was
> removed on 2026-08-16, and the account-deletion localization it lists as
> outstanding was already done. See
> [play-store-readiness-audit.md](play-store-readiness-audit.md) for the
> verified current state; that document is authoritative where the two differ.

## Goal

Publish Xenoh on Google Play without an in-app customer payment flow. Website
subscriptions grant access in the mobile app; the mobile app only reads and
enforces the resulting subscription state.

## Ownership

| Area | Owner | Required outcome |
|---|---|---|
| Backend | .NET API team | Account deletion, subscription state, data retention, reviewer access |
| Flutter mobile | Mobile team | No payment flow or payment-steering content; account deletion UI; current subscription access |
| Website | Web team | Public privacy and account deletion pages; website subscription checkout |
| Play Console | Release owner | Signing, listing, declarations, testing, production submission |

## Phase 1: Backend

### 1. Account deletion

Implement both endpoints:

```http
DELETE /api/users/me
Authorization: Bearer <access token>
```

```http
POST /api/auth/account-deletion-requests
Content-Type: application/json

{ "email": "user@example.com" }
```

Requirements:

- `DELETE /api/users/me` permanently deletes or anonymizes all deletable user
  data, then revokes access tokens and refresh tokens.
- Delete or anonymize profile data, avatars, workout plans/logs, bodyweight,
  nutrition data, cycle data, coach-client links, messages, community content,
  reports, and subscription records as appropriate.
- Retain only legally necessary data. Record the reason and retention period.
- `POST /api/auth/account-deletion-requests` always returns `202 Accepted`.
  Do not reveal whether an account exists for the submitted email.
- Send an email verification link before executing a deletion request made
  outside the authenticated app.
- Add audit logs for request, verification, completion, and failure.

Acceptance criteria:

- An authenticated user can delete an account from mobile Settings.
- A user without the app can submit their email on the public web page.
- Deleted users cannot authenticate or refresh a session.
- A support/admin process can audit deletion requests without restoring data.

### 2. Website subscription state

Keep this mobile endpoint:

```http
GET /api/subscriptions/me
Authorization: Bearer <access token>
```

Requirements:

- Website checkout is the only customer purchase path.
- The website payment webhook verifies payment and updates the server-side
  subscription record.
- `GET /api/subscriptions/me` returns the active tier, expiry, and AI quota.
- The backend remains the only authority for Pro/Pro Coach authorization.
- Do not expose payment-order, bank-transfer, QR, or development activation
  endpoints to the mobile client.

Acceptance criteria:

- A website purchase activates Pro in the mobile app after refresh or relogin.
- Expired or refunded website subscriptions lose Pro access in mobile.
- Protected backend endpoints reject inactive subscriptions regardless of the
  client UI state.

### 3. Reviewer access

Prepare one non-production reviewer account with every relevant role and a
stable password. Document all gated flows for Play Console App Access.

## Phase 2: Flutter Mobile

### 1. Payment removal

Completed:

- Payment-order API, DTOs, entity, QR screen, and bank-transfer flow removed.
- Mobile subscription repository now only reads current subscription status.

Still required:

- Remove remaining unused bank-transfer, VietQR, SePay, payment-order, and
  developer-activation localization strings from `lib/l10n`.
- Remove or restrict the admin payment screen from the Play build if Play
  reviewers can reach it.
- Do not add a link, button, copy, browser launch, or deeplink that directs
  Play Android users to website checkout unless a Google-approved regional
  external-payments program applies.

Acceptance criteria:

- A release APK/AAB contains no customer payment screen, payment endpoint, QR
  payment content, bank-transfer instructions, or external checkout link.
- Website-subscribed users can use their entitled mobile features.

### 2. Account deletion UI

Completed:

- Settings has an authenticated account-deletion confirmation flow.
- Public `/account-deletion` route submits an email-based deletion request.

Still required:

- Replace current hard-coded English deletion text with English and Vietnamese
  localization entries.
- Test success, backend validation error, expired session, and network failure
  states against the deployed API.

### 3. Privacy and user-generated content

Requirements:

- Keep the in-app Privacy Policy and Terms routes available without login.
- Require acceptance of Terms before users post community content or upload
  chat images.
- Confirm report and block actions work for public community content and
  direct-message users.

## Phase 3: Website

Deploy these public HTTPS pages before Play Console submission:

| URL | Purpose |
|---|---|
| `https://xenoh.online/privacy` | Public, non-PDF privacy policy |
| `https://xenoh.online/account-deletion` | Email-based account-deletion request form |
| Website checkout pages | Subscription purchase and refund support |

Privacy policy must state:

- Xenoh legal entity name, effective date, contact email, and jurisdiction.
- Data collected: account/profile data, date of birth/gender, fitness and
  nutrition data, photos, messages/community content, and subscription data.
- Purposes, processors/subprocessors, sharing, security, and retention.
- Account deletion process, verification method, deletion timeline, and any
  data retained for legal, fraud, or accounting reasons.
- How users request support, refunds, and data deletion.

Acceptance criteria:

- Each URL is publicly accessible without app installation or account login.
- The deletion page clearly references Xenoh and submits a working request.
- Privacy policy content exactly matches the Play Data Safety answers.

## Phase 4: Android Release

1. Create a Xenoh-owned upload keystore and store a backup outside source
   control.
2. Copy `android/key.properties.example` to `android/key.properties` and set
   the real keystore values.
3. Enrol package `online.xenoh.xenoh_mobile` in Play App Signing.
4. Increment `versionCode` for every later upload.
5. Build and inspect the signed AAB:

```powershell
flutter test
flutter analyze
flutter build appbundle --release --dart-define=API_BASE_URL=https://api.xenoh.online/api --dart-define=ALLOW_BAD_CERT=false
```

Acceptance criteria:

- Release AAB is signed by the Xenoh upload key, never `Android Debug`.
- AAB target SDK remains at or above the current Play minimum.
- All tests pass; only accepted analyzer information remains.

## Phase 5: Play Console

1. Create the app using package `online.xenoh.xenoh_mobile`.
2. Upload the signed AAB to internal testing first.
3. Complete App content declarations:
   - Privacy policy URL
   - Data Safety, including account, health/fitness, nutrition, photos,
     messages/community content, and subscription data
   - Data deletion answers and public deletion URL
   - Content rating
   - Target audience
   - Ads declaration
   - App Access reviewer account and instructions
4. Add store listing assets: app name, short/full descriptions, screenshots,
   icon, feature graphic, category, and contact details.
5. Run closed testing. New personal developer accounts require 12 testers
   opted in continuously for 14 days before production access.
6. Fix all Play pre-launch report and policy findings before production.

## Release Gate

Do not submit for production until every item is true:

- [ ] Backend deletion endpoints are deployed and tested.
- [ ] Public privacy and account deletion pages are live.
- [ ] Android payment and payment-steering content is absent.
- [ ] Data Safety declarations match actual behavior.
- [ ] Release AAB is signed with the Xenoh upload key.
- [ ] Reviewer account and instructions work.
- [ ] Internal/closed test passes on physical Android devices.
- [ ] Play Console has no blocking policy or pre-launch findings.
