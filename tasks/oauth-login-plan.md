# Implementation Plan: Google and Facebook Login to Dashboard

## Goal

Users who choose Google or Facebook on the Flutter login screen must complete the backend-owned OAuth flow, return to the mobile application, establish the normal Xenoh session, and reach `/dashboard`.

## Current Flow

1. Mobile opens `GET /api/auth/external/{provider}?client=mobile` in a secure browser session.
2. ASP.NET Core completes Google/Facebook authentication on its HTTPS callback.
3. The backend redirects to `xenoh://auth/social-callback` with a five-minute, single-use ticket.
4. Mobile allowlists the callback, posts the ticket to `/api/auth/external/exchange`, stores the resulting session, refreshes user-scoped dependencies, and routes to `/dashboard`.

## Pre-Implementation Audit

### Stack and repository state

- Flutter 3.44.8 / Dart 3.12.2.
- `go_router` 17.3.0 and `flutter_web_auth_2` 4.1.0.
- Backend is .NET 10 with ASP.NET Core Identity, Google/Facebook authentication 10.0.7, JWT, EF Core, and PostgreSQL.
- Mobile branch: `codex/mobile-social-login`, clean, two commits ahead of its remote.
- Backend `main` is clean and already contains the mobile callback/ticket contract.

### Conditions already verified

- Google production challenge returns HTTP 302 to `accounts.google.com` with callback `https://api.xenoh.online/api/auth/external/google/callback`.
- Facebook production challenge returns HTTP 302 to Facebook with callback `https://api.xenoh.online/api/auth/external/facebook/callback`.
- Arbitrary external-login clients are rejected with HTTP 400.
- Development provider identifiers/secrets are configured; their values were not printed or copied.
- Backend validates the exact mobile return URI `xenoh://auth/social-callback` in non-development environments.
- Android registers one exact callback filter and routes warm callbacks through `MainActivity.onNewIntent`.
- iOS registers the `xenoh` scheme.
- The callback ticket is not placed directly into the normal access-token store; it is exchanged through the backend for the standard session.

### Baseline evidence

- Focused mobile auth/router tests: 37 passed.
- Full mobile suite: 333 passed.
- `flutter analyze`: no issues.
- Debug APK: built successfully.
- Focused backend OAuth tests: 17 passed.
- Android 17 emulator:
  - Google opened in a Chrome Custom Tab at `accounts.google.com`.
  - Facebook opened in a Chrome Custom Tab at `m.facebook.com`.
  - Warm callback returned to the running app and rendered the expected callback result.
  - Cold callback launched the app and rendered the expected callback result.

## Implementation Tasks

**Delivery status:** Tasks 1-3 are complete. Android Facebook certification in
Task 4 is complete; Google and iOS remain external release-certification gates.

### Task 1: Make the API origin safe for release builds

**Description:** Keep the convenient `10.0.2.2` default for debug development, but make an omitted `API_BASE_URL` resolve to `https://api.xenoh.online/api` in release builds. Document that emulator OAuth must use the production API or a provider-registered, trusted HTTPS tunnel; Flutter's bad-certificate override does not apply to the external browser, and a raw emulator IP is not a valid production OAuth redirect origin.

**Acceptance criteria:**

- Release configuration cannot silently target `10.0.2.2`.
- An explicit `API_BASE_URL` still wins in every build mode.
- Debug development retains its current local default.
- Tests cover debug default, release default, and explicit override behavior.

**Verification:**

- `flutter test test/core/config/app_config_test.dart`
- `flutter analyze`
- Release/config smoke build with the resolved production origin.

**Dependencies:** None.

**Files likely touched:**

- `lib/core/config/app_config.dart`
- `test/core/config/app_config_test.dart`
- `README.md`

**Estimated scope:** Small.

### Task 2: Add a single deterministic login-to-Dashboard regression

**Description:** Add one combined widget-flow test that starts on Login, selects each provider, receives the allowlisted callback, exchanges a fake one-time ticket through the repository boundary, transitions to authenticated state, and verifies Dashboard navigation. Existing focused tests remain; this closes the gap between their separately tested segments without automating third-party provider UI.

**Acceptance criteria:**

- The Google path reaches Dashboard after one ticket exchange.
- The Facebook path reaches Dashboard after one ticket exchange.
- A duplicate callback cannot cause a second ticket exchange.
- Provider error, missing ticket, and exchange failure remain on a retryable unauthenticated screen.

**Verification:**

- New focused widget-flow test passes.
- Existing `test/features/auth` and `test/app/router` suites pass.

**Dependencies:** Task 1 only for final release configuration; test implementation is otherwise independent.

**Files likely touched:**

- `test/features/auth/social_login_flow_test.dart`
- Existing auth test helpers only if reuse is clearer than duplication.

**Estimated scope:** Small.

### Task 3: Re-run platform and backend contract gates

**Description:** Re-run the exact checks that establish the cross-layer contract after Tasks 1-2. Do not change the backend unless a failing contract test identifies a backend defect.

**Acceptance criteria:**

- Mobile and backend callback URLs remain byte-for-byte compatible.
- Android owns exactly one callback intent filter.
- iOS still owns the `xenoh` URL scheme.
- Successful ticket exchange authenticates before route redirection.

**Verification:**

- Focused mobile auth/router tests.
- Full `flutter test`.
- `flutter analyze`.
- `flutter build apk --debug`.
- Focused backend OAuth tests.
- Android warm/cold callback smoke checks.

**Dependencies:** Tasks 1-2.

**Files likely touched:** None unless a regression is found.

**Estimated scope:** Small.

### Task 4: Provider and device release certification

**Description:** Complete real consent and account-selection flows using non-production test accounts. This is a release gate, not an automated source change.

**Acceptance criteria:**

- Google: consent/account selection returns to the app, creates or links the expected user, and opens Dashboard with an authenticated API request.
- Facebook: consent/account selection returns to the app, returns an email claim, creates or links the expected user, and opens Dashboard with an authenticated API request.
- Cancellation, provider denial, expired ticket, replayed ticket, logout, and second-account login are retryable and do not leak a prior session.
- Both warm and cold app states pass on Android and iOS.

**Verification:**

- Android physical device or release-like emulator with a provider tester account.
- iPhone/iPad build from macOS with a provider tester account.
- Provider consoles confirm the exact HTTPS backend callbacks above, production/tester status, and Facebook email permission.

**Dependencies:** Tasks 1-3 and access to provider tester accounts plus an iOS build environment.

**Files likely touched:** None.

**Estimated scope:** Medium external QA.

## Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Release built without `API_BASE_URL` | Social login opens an unreachable emulator backend | Task 1 uses a production-safe release default and tests the resolver |
| Provider console callback differs by scheme, host, path, or trailing slash | Provider rejects login before returning to Xenoh | Verify the two exact HTTPS callback URLs in Task 4 |
| Facebook app lacks email permission or tester/live access | Backend cannot create/link the user | Verify email permission and app/tester status before release |
| Callback delivered twice by native routing and browser-session completion | Ticket replay or duplicate navigation | Existing controller deduplicates by ticket; Task 2 locks this behavior |
| Facebook appends its `_=_` compatibility fragment to the mobile callback | Dart rejects the otherwise valid ticket callback and leaves the user on Login | Allow and strip only the exact `_=_` marker; continue rejecting every other fragment in native and Dart tests |
| App is killed while the browser is open | In-memory browser result is lost | Cold deep link is independently handled by Flutter Router; Android cold-start smoke test already passes |
| Private-use `xenoh://` scheme can be claimed by another installed app | A malicious app could intercept the short-lived bearer ticket before Xenoh exchanges it | The five-minute, single-use ticket limits replay; schedule a coordinated migration to verified App/Universal Links or bind ticket exchange to the initiating app with PKCE |
| iOS runtime cannot be exercised from Windows | iOS-specific regression remains possible | Keep static tests and require macOS/iOS certification in Task 4 |
| Kotlin plugin migration warning | Future Flutter versions may reject current plugins | Current build passes; track separately because changing unrelated plugins would expand OAuth scope |

## External Preconditions

- Google Cloud OAuth client contains the exact production Google callback.
- Meta/Facebook Login contains the exact production Facebook callback, email permission is enabled, and the account is an allowed tester or the app is live.
- Production secrets remain in the deployment secret store, never in source control or logs.
- Real test-account passwords are entered only in the provider UI; they must not be pasted into task chat or committed files.
- iOS certification requires a macOS/iOS build environment.
- Native callback hardening requires a coordinated backend/domain/platform decision: verified HTTPS App/Universal Links or PKCE-bound ticket exchange.

## Post-Implementation Verification

- Combined Google/Facebook callback-to-Dashboard regression: 2 passed.
- Focused config/auth/router suite: 44 passed.
- Full Flutter suite: 340 passed.
- `flutter analyze`: no issues.
- Debug and signed release APKs: built successfully.
- Focused backend OAuth suite: 17 passed.
- Signed release APK built without `API_BASE_URL`:
  - Google opened `accounts.google.com`.
  - Facebook opened `m.facebook.com`.
  - Warm and cold callbacks returned to the release app.
  - Real Facebook consent returned a one-time ticket with the `_=_` marker,
    exchanged it successfully, opened Dashboard, and restored Dashboard after
    force-stop/relaunch.

## Implementation Gate

The pre-implementation audit completed before source changes began. The requested "no bug/error" outcome is treated as a release target supported by automated and device evidence; final certification still requires the real-provider and iOS checks in Task 4.
