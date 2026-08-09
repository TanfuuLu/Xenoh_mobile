# Website–Mobile Sync Backlog

Each item is a vertical slice: route/UI, API integration, permission handling, localization, loading/empty/error states, and tests ship together.

## Delivery status â€” 3 August 2026

- [x] P0-02 native subscription catalog, promotion validation, payment order, and handoff.
- [x] P1-01 through P1-07 core athlete/coach workflows, deletion verification, and safe notification destinations.
- [x] P2-01 nutrition/volume history.
- [x] P2-02 community report/copy and unified kudos reaction.
- [x] P2-03 Fitness Challenges full athlete lifecycle.
- [x] P2-04 competition discovery, registration, receipt, withdrawal, and mine.
- [x] P2-05 Files/Storage native athlete/coach slice.
- [x] P2-06 Admin user lifecycle and subscription adjustment verification.
- [x] P2-07 authoritative chat unread counts with SignalR/reconnect/resume reconciliation.
- [ ] P0-01 OpenAPI regeneration remains backend/CI infrastructure work; mobile contract tests now protect every delivered slice.
- [x] P3 organizer and operational admin workflows approved for mobile: Organizer event operations/results plus Admin payments, promotions, and organizer verification.

## P0 — Release/commercial blocker

### P0-01 Regenerate and enforce the backend contract

- Generate OpenAPI from the running API instead of treating the stale committed file as authoritative.
- Compare generated operations with controller source in CI.
- Generate or validate web/mobile client contracts from the same artifact.
- Acceptance: all current controller operations are represented; CI fails on unexplained drift.

### P0-02 Native subscription purchase

- Add catalog query, selected product state, promotion validation, payment-order creation, payment handoff, and entitlement refresh.
- Preserve existing architecture: datasource → repository → application/controller → presentation.
- Cover cancellation, expired promotion, duplicate purchase, network retry, and payment return deep link.
- Acceptance: an eligible user can purchase the same available plan and receives the same entitlement state as web.

## P1 — Core athlete/coach workflow parity

### P1-01 Coach client Today Workout

- Add a client-scoped route from the client detail action.
- Resolve the client's current workout with coach authorization.
- Support read/edit actions only where backend policy permits.
- Acceptance: coach can open the same workout and fields available on web.

### P1-02 Client custom exercise full CRUD

- Extend the existing list/create implementation with edit and delete.
- Add validation, destructive confirmation, optimistic/refresh behavior, and relationship-expired handling.
- Acceptance: create/edit/delete results match web after refresh.

### P1-03 Client nutrition detail

- Add client-scoped daily intake, date navigation, food-log detail, history, and meal-plan entry point.
- Reuse nutrition DTOs only where response contracts are actually identical.
- Acceptance: Demo Athlete shows the same goal, TDEE, target, macros, daily entries, totals, and dates on both surfaces.

### P1-04 Athlete and client nutrition insight

- Implement native insight presentation based on the same summary/input contract as web.
- Add tier gates, insufficient-data, refresh, 403, and 429 states.
- Acceptance: sections and recommended actions are semantically equivalent for the same account.

### P1-05 Workout set editing and previous performance

- Add the general set update command.
- Fetch and display last exercise performance near working sets.
- Test completed, skipped, reopened, invalid RPE, and unit-conversion cases.
- Acceptance: users can correct set data without data loss and compare with their previous session.

### P1-06 Account deletion verification

- Product chooses native deep link or browser completion.
- If native: parse token, call verification endpoint, show final state, clear session if required.
- Acceptance: a deletion email link completes reliably whether the app is installed or not.

### P1-07 Notification destination safety

- Map supported entity types to real mobile routes.
- For capabilities not yet built, show a safe detail/fallback instead of navigating to nowhere.
- Acceptance: every backend notification type has a tested destination or explicit fallback.

## P2 — Expansion parity

### P2-01 Nutrition history and progress volume history

- Add athlete nutrition history/date range.
- Add volume-history chart and filters to Progress.
- Acceptance: web/mobile totals use the same dates, units, and timezone boundaries.

### P2-02 Community share actions

- Add report and copy-workout/share actions.
- Decide whether web kudos and mobile love are one reaction model or separate actions.
- Acceptance: permission and owner/non-owner actions match backend policy.

### P2-03 Fitness Challenges

Deliver separately:

1. Discover/detail.
2. Join/accept/decline/leave.
3. Create/invite/member management.
4. Daily check-in and cancellation.

### P2-04 Competition athlete flows

Deliver separately:

1. Public discovery/detail.
2. Registration/cancellation/receipt.
3. My competitions and notification destinations.

### P2-05 Storage decision and athlete slice

- Confirm that Files is Mobile Required.
- If approved: native picker, upload progress, list, download/open, delete, share/unshare, storage limits.

### P2-06 Admin user lifecycle

- Add suspend/unsuspend with reason and confirmation.
- Verify subscription adjustment fields and audit trail.

### P2-07 Chat unread parity

- Integrate `/messages/unread-counts` or document/prove equivalent SignalR-derived state.
- Test reconnect, duplicate event, background/resume, and read race conditions.

## P3 — Web-first or product-decision scope

- Organizer competition create/manage/results on mobile.
- Admin payments and subscription operations.
- Admin promotion-code CRUD.
- Admin organizer evidence/review/decision.
- Community leaderboard.
- Additional public marketing/About/legal pages beyond required in-app legal access.

## Recommended delivery order

1. Contract regeneration and contract tests.
2. Subscription purchase.
3. Coach client Today Workout + client exercise CRUD.
4. Client nutrition detail + nutrition insights.
5. Workout set editing + last performance.
6. Account deletion + notification fallbacks.
7. P2 domain slices after product decisions.

## Definition of done for every slice

- Exact backend method/path/payload/response documented.
- Actor, role, relationship, consent, and subscription policy tested.
- Loading, empty, error, retry, refresh, and destructive confirmation covered.
- English and Vietnamese strings included.
- 320/390/768 layouts and accessibility checked.
- Unit/widget tests plus at least one integration happy path and one forbidden/error path.
- Same account/data produces equivalent business outcome on web and mobile.
