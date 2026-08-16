# Google and Facebook Login to Dashboard Checklist

## Audit

- [x] Trace Login → provider → backend callback → app callback → ticket exchange → Dashboard.
- [x] Verify provider challenge URLs and exact production backend callbacks.
- [x] Verify Android and iOS callback registration.
- [x] Verify callback allowlisting and duplicate-ticket protection.
- [x] Run focused mobile auth/router tests (37 passed).
- [x] Run full mobile tests (333 passed).
- [x] Run static analysis (no issues).
- [x] Build the debug APK.
- [x] Run focused backend OAuth tests (17 passed).
- [x] Smoke-test Google and Facebook Custom Tabs on Android 17.
- [x] Smoke-test warm and cold Android callbacks.

## Implementation after approval

- [x] Add a production-safe API origin resolver for release builds.
- [x] Test debug default, release default, and explicit `API_BASE_URL` override.
- [x] Document trusted HTTPS requirements for emulator/provider OAuth.
- [x] Add the combined Google/Facebook login-to-Dashboard widget regression.
- [x] Prove duplicate callback delivery performs one ticket exchange.

## Regression checkpoint

- [x] Focused config test passes.
- [x] Focused social login flow test passes.
- [x] All auth/router tests pass (43 tests after implementation).
- [x] Full Flutter suite passes (338 tests).
- [x] `flutter analyze` reports no issues.
- [x] Debug and signed release APKs build.
- [x] Focused backend OAuth tests pass (17 tests).
- [x] Android warm/cold callback smoke tests pass after changes.
- [x] Signed release defaults to the production API and opens both providers.
- [x] Git diff contains no secrets or unrelated changes.

## External release certification

- [ ] Google provider console has `https://api.xenoh.online/api/auth/external/google/callback`.
- [ ] Facebook provider console has `https://api.xenoh.online/api/auth/external/facebook/callback`.
- [ ] Facebook email permission and app tester/live status are valid.
- [ ] Real Google test account reaches Dashboard on Android.
- [ ] Real Facebook test account reaches Dashboard on Android.
- [ ] Real Google test account reaches Dashboard on iOS.
- [ ] Real Facebook test account reaches Dashboard on iOS.
- [ ] Cancellation, denial, expired/replayed ticket, logout, and account switching pass.
