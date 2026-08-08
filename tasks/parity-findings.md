# Website–Mobile Parity Findings

## Delivery summary — 6 August 2026

The approved P0, P1, and P2 mobile parity backlog has been implemented against:

- Mobile: `E:\Xenoh_mobile`
- Website reference: `E:\Xenoh\Xenoh_fe`
- Backend contract source: `E:\Xenoh\Xenoh_be`

The implementation compares business outcomes, API contracts, permissions, fields, actions, and native states. It does not require route-for-route or pixel-for-pixel duplication.

## Completed gaps

| Domain | Delivered mobile outcome |
|---|---|
| Subscription | Server catalog, promotion validation, terms gate, payment order, payment handoff, entitlement refresh |
| Coach client | Correct client profile API, today workout, full custom-exercise CRUD, nutrition detail/history, nutrition insight |
| Workout | General set editing and last exercise performance |
| Account | Public deletion verification route with exact token payload and session clearing; browser email link remains fallback |
| Notifications | Tested destination resolver for supported entities and safe fallback for unsupported ones |
| Nutrition/Progress | Athlete history, date ranges, nutrition insight, volume history with ranges and units |
| Community | Report, copy workout, canonical kudos reaction, full Fitness Challenge athlete lifecycle |
| Community standings | Ranked challenge members with avatar, creator/baseline state, score, and unit |
| Competitions | Public list/detail plus athlete registration, withdrawal, receipt upload, mine, and destinations |
| Files | Quota, native picker/upload progress, owned/shared files, signed-URL open, delete, share/unshare |
| Admin | Account status, confirmed suspend/unsuspend, and verified subscription-adjustment payload |
| Chat | Authoritative unread-count endpoint, per-relationship badges, mark-read, SignalR/reconnect/resume reconciliation |

## Contract findings retained

1. The committed backend OpenAPI remains materially incomplete. Controller source and current web hooks were used as primary evidence, and focused mobile contract tests now lock delivered paths and payloads.
2. Admin suspend/unsuspend endpoints accept no reason payload. Mobile matches web/backend and does not invent a field; the subscription adjustment endpoint still sends its required audit reason.
3. Account-deletion emails still use the backend `FrontendUrl`, so browser completion works whether the app is installed or not. The mobile public verification route is available when the URL is routed into the app.
4. Chat SignalR events are invalidation signals, not counters. `/messages/unread-counts` remains authoritative, preventing duplicate and out-of-order event drift.

## Newly approved operational scope

The latest approved redesign explicitly moved these former web-first workflows into mobile scope:

- Competition organizer application, event lifecycle/editing, categories, staff, roster/payment review, and results.
- Admin payments and subscription operations.
- Admin promotion-code CRUD and status controls.
- Admin organizer evidence/review/decision.
- Community leaderboard.
- Non-essential public marketing route duplication.

## Verification evidence

- `flutter analyze`: passed with no issues.
- `flutter test`: passed, 221 tests at the final full-suite checkpoint.
- `flutter build apk --debug`: passed; output at `build/app/outputs/flutter-apk/app-debug.apk`.
- Focused API contract tests cover the newly delivered subscription, coach/client, nutrition, workout, deletion, notifications, community, challenges, competitions, storage, admin, and chat slices.
- Screen inventory: 81 screen classes across 71 screen files; every screen file passes the supported-page-frame audit.
- Layout regression includes 320, 390, and 768 widths plus English/Vietnamese shared frames.

## Remaining release gate

Static implementation and automated regression are complete. Production release certification still requires representative Free Athlete, Pro Athlete, Coach, Pro Coach, Admin, and Organizer accounts against a running environment to compare real data, authorization, payment return behavior, uploaded files, and push/reconnect behavior. No production credentials or data were assumed or mutated during this implementation.

Row-level status and evidence remain in `tasks/parity-matrix.csv`; delivery order is in `tasks/sync-backlog.md`; platform decisions are in `tasks/decision-log.md`.
