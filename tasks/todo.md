# Website–Mobile Parity Audit Checklist

## Static audit result — 3 August 2026

- [x] Created `tasks/parity-matrix.csv` with 60 evidence-backed capabilities.
- [x] Inventoried web/mobile routes, navigation, API calls, and backend controller operations.
- [x] Published `tasks/parity-findings.md`, `tasks/decision-log.md`, and `tasks/sync-backlog.md`.
- [x] Confirmed unmatched routes were not classified as missing from route names alone.
- [x] Ran `flutter analyze` successfully with no issues.
- [x] Ran `flutter test` successfully with all 170 tests passing after parity implementation.
- [x] Built `build/app/outputs/flutter-apk/app-debug.apk` successfully.
- [ ] Run the runtime parity pass with Free Athlete, Pro Athlete, Coach, Pro Coach, Admin, and Organizer data.
- [ ] Approve the Pending/Proposed items in `tasks/decision-log.md` before implementing P2/P3 scope.

## Audit setup

- [ ] Create `tasks/parity-matrix.csv` using the schema in `tasks/plan.md`.
- [ ] Inventory all web/mobile routes, navigation entries, deep links, and role gates.
- [ ] Map every capability to OpenAPI operations and authorization/subscription rules.
- [ ] Prepare Free Athlete, Pro Athlete, Coach, Pro Coach, Admin, and Organizer test states.
- [ ] Prepare empty, normal, error, and boundary datasets.

## Public and authentication

- [ ] Landing, About, Legal, Privacy, Terms, Refund.
- [ ] Pricing vs native subscription equivalence.
- [ ] Public competition list and detail.
- [ ] Register and validation rules.
- [ ] Login, session restoration, expiry, and logout.
- [ ] Social authentication callback.
- [ ] Forgot-password request.
- [ ] Verification-code step.
- [ ] Password reset step.
- [ ] Change password.
- [ ] Account deletion request and verification.

## Athlete core

- [ ] Dashboard cards, actions, and data freshness.
- [ ] Notification center, unread state, and deep links.
- [ ] Profile fields, avatar, bio, social links, stats, and edit flow.
- [ ] Settings: language, theme, units, RPE, privacy, blocklist.
- [ ] Subscription status, entitlements, upgrade/downgrade/cancel paths.
- [ ] Files/storage list, upload/download/delete, limits, and native alternatives.

## Training and workouts

- [ ] Plan list, pagination, filters, and ownership.
- [ ] Create, duplicate, activate, deactivate, delete plan.
- [ ] Plan detail vs web plan overview equivalence.
- [ ] Plan analytics, balance check, design analysis, progress insight.
- [ ] Week detail, analysis, comments, and editing.
- [ ] Day workout structure and editing.
- [ ] Exercise template list/search/filter.
- [ ] Custom exercise create/edit/delete.
- [ ] Workout set tracking, RPE, timer, notes, PR state, skip/complete.
- [ ] Today-workout resolution and active-plan rules.
- [ ] Plan/week comments and permissions.

## Progress and AI

- [ ] Progress overview metrics and date filters.
- [ ] Bodyweight history, charts, total/average change, and units.
- [ ] Personal records, history, and sharing.
- [ ] Powerlifting/DOTS analysis.
- [ ] Personal AI insights response sections.
- [ ] Plan AI analyses and response sections.
- [ ] AI coach chat conversations and history.
- [ ] Pro gating, 403, 429, cache, refresh, and empty-data behavior.

## Nutrition, supplements, and cycle

- [ ] Nutrition profile and calculation fields.
- [ ] Today log, food search, add/edit/delete food.
- [ ] Meal-plan day and week create/edit flows.
- [ ] Personal nutrition insight.
- [ ] Coach client nutrition summary and detail.
- [ ] Coach client nutrition insight.
- [ ] Supplement CRUD, regimen, dose schedule, and reminders.
- [ ] Cycle tracking, prediction, symptoms, and settings.
- [ ] Cycle sharing consent and coach visibility.
- [ ] Cycle AI insight and missing-data behavior.

## Coach-client

- [ ] Client list/dashboard, filters, status, alerts, and progress.
- [ ] Client profile fields and bodyweight history.
- [ ] Client plan creation, active plan, progress, and today workout.
- [ ] Client custom exercise list/create/edit/delete.
- [ ] Client nutrition and nutrition insight.
- [ ] Client cycle detail and sharing restrictions.
- [ ] Client AI brief and suggested message.
- [ ] Invite code/key vault create/delete/expiry.
- [ ] Enter coach code and relationship lifecycle.
- [ ] Coach profile.
- [ ] Coach-client chat list, thread, unread, send, and reconnect states.

## Community and competitions

- [ ] Community landing sections.
- [ ] Community feed and interactions.
- [ ] Community challenges.
- [ ] Public/community user profile.
- [ ] Friends list/request/accept/reject/remove.
- [ ] Block and report flows.
- [ ] Competition discovery and detail.
- [ ] Competition registration and cancellation.
- [ ] My competitions.
- [ ] Organizer competition list.
- [ ] Competition create/edit/manage/results workflows.

## Admin and operations

- [ ] Admin dashboard.
- [ ] Admin users and user detail/actions.
- [ ] Admin plans and plan analytics.
- [ ] Admin reports and bug reports.
- [ ] Admin insights.
- [ ] Admin marketing.
- [ ] Admin payments.
- [ ] Admin promotions.
- [ ] Admin competition organizers.
- [ ] Record Mobile Required, Read-only Mobile, or Web-only decision for each.

## Cross-cutting checks for every row

- [ ] Exact API method/path/parameters/payload/response.
- [ ] Role, policy, owner ID, client ID, and subscription tier.
- [ ] Displayed fields and supported actions.
- [ ] Loading, empty, error, retry, refresh, and offline states.
- [ ] Validation and destructive-action confirmation.
- [ ] Pagination, sorting, filtering, and caching.
- [ ] English/Vietnamese localization.
- [ ] Accessibility and 320/390/768 responsive layouts.
- [ ] Automated test coverage and runtime evidence.
- [ ] Final status and prioritized recommended action.

## Audit completion

- [ ] Publish `tasks/parity-findings.md` with evidence-backed gaps.
- [ ] Publish and approve `tasks/decision-log.md`.
- [ ] Publish `tasks/sync-backlog.md` with P0–P3 vertical slices.
- [ ] Confirm no item is marked missing from route names alone.
- [ ] Record baseline analyze/test/APK build results.
- [ ] Review and approve the plan before implementation begins.

## Application-wide proportional scaling — approved 5 August 2026

- [x] Add failing tests for the 390px baseline and `0.90–1.20` clamp.
- [x] Implement the root proportional scaling frame.
- [x] Verify safe-area, keyboard inset, and accessibility text scaling.
- [x] Integrate the frame with all routes and overlays.
- [x] Run 320/390/468 responsive tests, analyzer, full tests, and debug APK build.
