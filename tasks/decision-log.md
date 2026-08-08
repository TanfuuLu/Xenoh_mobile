# Website–Mobile Parity Decision Log

| ID | Capability | Decision | Status | Rationale / next owner |
|---|---|---|---|---|
| D-001 | Source of backend truth | Use controller source plus active runtime schema until OpenAPI is regenerated | Accepted for audit | Committed OpenAPI is materially incomplete. Backend owner to automate regeneration. |
| D-002 | Forgot-password pages | Treat combined native flow as Equivalent | Accepted | Same user outcome; separate route count is not a parity requirement. |
| D-003 | Community Feed | Treat feed embedded in CommunityScreen as Equivalent | Accepted | Mobile calls the same feed contract and exposes reaction behavior. |
| D-004 | Coach Profile | Treat MyCoachScreen as the mobile equivalent | Accepted with gap | Add supported social links if required; do not create a duplicate route merely for name parity. |
| D-005 | Admin analytics pages | Keep Insights, Marketing, and AI Usage combined on mobile | Accepted | Mobile calls all three endpoint groups; native consolidation is appropriate. |
| D-006 | Client Cycle | Keep overview folded into client detail | Accepted pending UX review | Backend client contract is overview-only. A new screen adds navigation without new outcome. |
| D-007 | Account deletion verification | Browser link remains the reliable fallback; mobile also implements the public verification route and exact token contract | Accepted | Backend email continues to target `FrontendUrl`, so deletion completes without requiring the app. Mobile `/account-deletion/verify?token=` verifies and clears the local session when reached. |
| D-008 | Files/Storage | Mobile Required | Accepted by implementation scope | User requested full website/mobile sync. Mobile provides quota, native picker/upload progress, owner/shared lists, signed-URL open, delete, coach share, and unshare. |
| D-009 | Organizer competition management | Mobile Required | Accepted by explicit redesign scope | The approved role navigation requires Organizer Home, Events, Roster, Results, and Profile. Mobile now implements application/evidence, event lifecycle/editing, categories, staff access, guest/roster/payment review, and discipline-specific results against the backend contracts. |
| D-010 | Admin payments/promotions/organizers | Mobile Required | Accepted by explicit redesign scope | The approved Admin Finance and Moderation destinations require operational parity. Mobile now exposes payment/subscription operations, promotion CRUD/status, and organizer evidence/review decisions. |
| D-011 | Kudos vs Love | Unified reaction | Accepted from backend contract | `/love` and `/kudos` are aliases for the same backend command and stored reaction. Mobile now uses the web-canonical `/kudos` route. |
| D-012 | Chat unread state | `/messages/unread-counts` is authoritative; SignalR triggers reconciliation | Accepted | Initial load, message event, reconnect, app resume, and mark-read all reconcile with the endpoint. Revision ordering prevents duplicate/out-of-order events from drifting badges. |
| D-013 | Public marketing/legal pages | Native screen only where platform/account policy requires | Proposed | Mobile does not need route-for-route marketing parity; legal and account actions must remain accessible. |

## Decision rule

A missing web route is not automatically a mobile defect. A capability can be excluded only when this log records the actor impact, alternative path, security/compliance implications, and approving owner. Until then it remains Missing or Partial in `parity-matrix.csv`.
