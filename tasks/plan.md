# Implementation Plan: Website–Mobile Feature Parity Audit

## Redesign implementation status — 6 August 2026

The audit plan has been executed as a full mobile redesign and parity delivery.
The current inventory contains **81 screen classes across 71 screen files**.
All 71 files pass the supported-page-frame contract, and the parity matrix has
no Missing or Partial capabilities.

Delivered role navigation:

- Athlete: Home, Training, Nutrition, Profile.
- Coach: Home, Clients, Chat, Profile.
- Organizer: Home, Events, Roster, Results, Profile.
- Admin: Overview, Users, Moderation, Finance, More.

The superseded proportional-scaling addendum below is retained as historical
decision context. The implemented design uses physical viewport dimensions,
responsive phone/tablet breakpoints, bottom navigation on compact layouts, and
a labeled navigation rail on expanded layouts.

## Overview

Audit `E:\Xenoh\Xenoh_fe`, `E:\Xenoh_mobile`, and the backend contract in
`E:\Xenoh\Xenoh_be\openapi.json` to identify capabilities that are missing,
partial, incorrect, or intentionally different on mobile. The target is
business-flow parity for Athlete, Coach, Admin, and public users; it is not a
pixel-for-pixel port of the website.

The audit must compare more than route names. Every feature is checked across:

1. Entry point and navigation.
2. Role, policy, and subscription entitlement.
3. API method, path, parameters, request payload, and response model.
4. Fields displayed and actions supported.
5. Loading, empty, error, validation, offline, and refresh states.
6. Localization, accessibility, and responsive mobile behavior.
7. Automated test and runtime evidence.

## Product Scope

### Primary users

- Athlete: training, progress, health tracking, community, billing, and account management.
- Coach: client management, plan delivery, monitoring, communication, and client-specific content.
- Admin/Organizer: operational workflows that are explicitly approved for mobile.
- Public visitor: marketing, legal, pricing, competition discovery, authentication, and account deletion.

### Definition of parity

| Status | Meaning |
|---|---|
| Complete | Mobile supports the same business outcome, permissions, data, actions, and critical states as web. |
| Partial | Mobile exists but misses fields, actions, states, API calls, or permission behavior. |
| Missing | No usable mobile workflow exists. |
| Equivalent | Mobile implements the capability in a different native flow with the same outcome. |
| Mobile-only | Deliberate mobile capability with no web equivalent. |
| Not applicable | Capability is intentionally excluded from mobile and the decision is recorded. |
| Blocked | Backend contract, product decision, credentials, or test data prevents verification. |

### Source-of-truth order

1. Backend OpenAPI and authorization policies.
2. Current web behavior and API hooks.
3. Mobile behavior and native UX conventions.
4. Product decision log for intentional platform differences.

Web implementation is evidence of expected behavior, but it does not override
the backend contract or justify porting an unsuitable desktop/admin workflow.

## Baseline Inventory

The first static scan found 69 web route declarations and 64 mobile route
declarations. Counts are not a parity score because one route may contain
multiple workflows and mobile may combine multiple web pages into one screen.

Initial candidates that require deep verification:

| Domain | Web capability with no obvious one-to-one mobile route | Initial classification |
|---|---|---|
| Authentication | Forgot-password code check, reset-password page | Verify whether combined into the mobile forgot-password flow |
| Account lifecycle | Account deletion verification | Verify whether handled externally or missing |
| Public/billing | Pricing page | Compare against mobile subscription screen |
| Storage | File/storage management | Likely missing |
| Community | Feed and challenges | Likely missing/partial |
| Competitions | Public detail, my competitions, organizer and management flows | Likely missing |
| Nutrition | Personal nutrition insight | Likely missing route |
| Coach | Coach profile | Likely missing |
| Coach/client | Today workout, dedicated nutrition, nutrition insight, dedicated cycle | Likely partial or folded into client detail |
| Admin | Insights, marketing, payments, promotions, organizers | Likely missing; product decision required before mobile implementation |
| Training | Plan overview route | Verify equivalence inside mobile plan detail |

These are hypotheses only. An item is not moved to the implementation backlog
until its API, fields, actions, permissions, and runtime behavior have been
checked.

## Required Audit Artifacts

The audit produces these files:

- `tasks/parity-matrix.csv`: one row per user-visible capability.
- `tasks/parity-findings.md`: evidence-backed gaps and screenshots/log references.
- `tasks/sync-backlog.md`: prioritized vertical implementation slices.
- `tasks/decision-log.md`: intentional differences and deferred web-only workflows.

Each parity-matrix row must contain:

```text
ID, actor, domain, capability, web route, mobile route, web source,
mobile source, API methods/paths, entitlement, web fields/actions,
mobile fields/actions, loading/empty/error states, test coverage,
status, severity, evidence, recommended action
```

## Dependency Graph

```text
Route/page inventory
        |
        +--> OpenAPI + authorization inventory
        |             |
        |             +--> Domain-by-domain contract audit
        |                           |
        +--> Test account matrix ---+
                                    |
                                    +--> Runtime verification
                                                |
                                                +--> Gap triage
                                                          |
                                                          +--> Sync backlog
```

## Task List

### Phase 1: Establish the audit baseline

## Task 1: Build the route, navigation, and page inventory

**Description:** Extract all public and protected entry points from both routers,
navigation menus, deep links, and feature/page folders. Map combined or renamed
mobile flows before declaring a route missing.

**Acceptance criteria:**

- [ ] Every web route and mobile route has an actor, role gate, and destination source file.
- [ ] Hidden navigation entries, deep links, and routes reachable only from buttons are included.
- [ ] Each unmatched route is labeled Candidate Missing, Candidate Equivalent, or Needs Runtime Check.

**Verification:**

- [ ] Route counts reconcile with both router source files.
- [ ] Spot-check at least one route per domain against its actual navigation entry.

**Dependencies:** None

**Files likely inspected:**

- `E:\Xenoh\Xenoh_fe\src\app\Router.tsx`
- `E:\Xenoh_mobile\lib\app\router\router.dart`
- Web/mobile navigation and shell components

**Estimated scope:** Medium

## Task 2: Build the API and authorization contract inventory

**Description:** Map web hooks and mobile providers/repositories to OpenAPI
operations, request/response DTOs, roles, policies, subscription tiers, pagination,
and expected status codes.

**Acceptance criteria:**

- [ ] Every audited capability has exact HTTP method and path, not inferred names.
- [ ] Request fields, response fields, nullability, pagination, and 403/404/409 behavior are recorded.
- [ ] Web/mobile calls that disagree with OpenAPI are flagged as contract defects.

**Verification:**

- [ ] Cross-check a sample from Auth, Training, Nutrition, Coach, Community, and Admin.
- [ ] No endpoint is marked missing only because one client uses a different API abstraction.

**Dependencies:** Task 1

**Files likely inspected:**

- `E:\Xenoh\Xenoh_be\openapi.json`
- `E:\Xenoh\Xenoh_fe\src\shared\api\endpoints.ts`
- Web API hooks under `src/features/**/api`
- Mobile data sources, repositories, and Riverpod providers

**Estimated scope:** Medium

## Task 3: Define runtime accounts, fixtures, and evidence rules

**Description:** Prepare a repeatable test matrix for Free Athlete, Pro Athlete,
Coach, Pro Coach, Admin, Organizer, connected/unconnected client, female cycle
sharing on/off, and populated/empty datasets.

**Acceptance criteria:**

- [ ] Every role/tier state required by the OpenAPI policies has a usable test account or fixture.
- [ ] Seed data covers empty, normal, and boundary states without modifying production data.
- [ ] Evidence naming conventions are defined for screenshots, network logs, and defects.

**Verification:**

- [ ] Each account can authenticate on web and mobile.
- [ ] Role/tier claims and expected navigation visibility are confirmed.

**Dependencies:** Task 2

**Files likely inspected:** backend seed/test configuration and existing local environment documentation

**Estimated scope:** Medium

### Checkpoint: Baseline ready

- [ ] `parity-matrix.csv` contains every route-level capability.
- [ ] OpenAPI and entitlement columns are populated.
- [ ] Test data is ready before runtime comparison starts.

### Phase 2: Deep functional audits

## Task 4: Audit authentication and account lifecycle

**Description:** Compare registration, social callback, login, forgot-password,
code verification, password reset, change password, logout, account deletion,
deletion verification, and session expiry.

**Acceptance criteria:**

- [ ] Happy paths and validation/error paths are mapped step by step.
- [ ] Token/session storage, redirect behavior, and role gates match backend policy.
- [ ] Combined mobile flows are classified Equivalent only after runtime verification.

**Verification:** focused auth tests plus manual web/mobile recovery and deletion sandbox flows

**Dependencies:** Tasks 1–3

**Files likely inspected:** Auth, Settings, and account-deletion features in both clients

**Estimated scope:** Medium

## Task 5: Audit athlete shell, dashboard, profile, settings, billing, notifications, and storage

**Description:** Compare all dashboard cards/actions, profile fields, preferences,
social/avatar behavior, notification center, subscription/entitlements, pricing,
file storage, legal pages, and public marketing entry points.

**Acceptance criteria:**

- [ ] Every displayed field and CTA is listed for web and mobile.
- [ ] Preference persistence and unit/language/theme behavior are verified.
- [ ] Pricing vs subscription and files/storage receive an explicit parity decision.

**Verification:** mobile widget tests, API contract tests, and screenshots at narrow phone and tablet widths

**Dependencies:** Tasks 1–3

**Files likely inspected:** Dashboard, Profile, Settings, Billing/Subscription, Notifications, Storage, Marketing

**Estimated scope:** Medium

## Task 6: Audit plans, weeks, days, exercise library, comments, and workout tracking

**Description:** Trace the full training lifecycle: list/create/duplicate/activate/
deactivate/delete plans; plan detail/overview/analytics/AI review; week/day CRUD;
exercise template CRUD; set tracking; RPE; timers; completion; comments; CSV or
sharing actions.

**Acceptance criteria:**

- [ ] Every web action has a mobile status and exact API mapping.
- [ ] Active-plan rules and progress calculations use the same source of truth.
- [ ] The complete workout flow works without falling back to raw or missing fields.

**Verification:** contract tests for mutations, widget tests for critical actions, and one end-to-end workout completion run

**Dependencies:** Tasks 1–3

**Files likely inspected:** Plans, Workouts, Exercise Tracking, Comments, Training

**Estimated scope:** Large; split findings into plan management, workout execution, and exercise library slices

## Task 7: Audit progress, personal records, sharing, and AI insights

**Description:** Compare progress summaries, charts, date filters, plan analytics,
powerlifting/DOTS data, PR history/sharing, AI insights, AI plan reviews, coach chat,
quota/cached states, and tier restrictions.

**Acceptance criteria:**

- [ ] All response sections and chart series are mapped field by field.
- [ ] 403, 429, cached, empty-data, and stale-data behavior is verified.
- [ ] Mobile-only PR sharing is recorded separately from web parity.

**Verification:** response fixtures, widget tests, and runtime checks with Free and Pro accounts

**Dependencies:** Tasks 1–3 and training contract knowledge from Task 6

**Files likely inspected:** Progress, Insights, Sharing, and related backend endpoints

**Estimated scope:** Medium

## Task 8: Audit nutrition, meal plans, supplements, and cycle tracking

**Description:** Compare nutrition profile/calculation/logging, food search,
meal-plan day/week workflows, nutrition insight, coach-client nutrition, supplement
regimens/schedules, cycle tracking, sharing consent, prediction, and AI insight.

**Acceptance criteria:**

- [ ] Nested response contracts and units are mapped field by field.
- [ ] Athlete and coach views expose the permitted data and mutations for the correct owner.
- [ ] Consent-gated cycle data and 404 empty semantics are verified.

**Verification:** API fixtures, mobile widget tests, and runtime checks for shared/unshared client data

**Dependencies:** Tasks 1–3

**Files likely inspected:** Nutrition, Supplements, Cycle, Coach Client

**Estimated scope:** Large; split findings into nutrition, supplements, and cycle slices

## Task 9: Audit coach-client management and communication

**Description:** Compare client list/dashboard, client profile, today workout,
plan creation/progress, custom exercise CRUD, nutrition, nutrition insight, cycle,
AI brief, invite codes/key vault, coach profile, relationship state, and chat.

**Acceptance criteria:**

- [ ] Every coach read/write action is verified against a connected client and permission policy.
- [ ] Dedicated web pages and combined mobile panels are compared for fields and actions, not route count.
- [ ] Disconnect, expired relationship, non-Pro, and missing-sharing states are covered.

**Verification:** regression tests for each client-scoped endpoint and an end-to-end Coach → Client workflow

**Dependencies:** Tasks 3, 6, and 8

**Files likely inspected:** Coach Client, Chat, Profile, Training, Nutrition, Cycle

**Estimated scope:** Large; split into relationship/chat and client-coaching slices

## Task 10: Audit community, moderation, and competitions

**Description:** Compare community landing, feed, posts/interactions, user profiles,
friends, challenges, block/report behavior, public competitions, registration,
my competitions, organizer workflows, and competition management.

**Acceptance criteria:**

- [ ] Feed/challenge/competition capabilities are separated into independent rows.
- [ ] Public, authenticated, organizer, and moderation permissions are recorded.
- [ ] Missing mobile competition scope is estimated as vertical slices, not one XL task.

**Verification:** API contract checks and runtime paths for public visitor, athlete, and organizer

**Dependencies:** Tasks 1–3

**Files likely inspected:** Community, Competitions, Blocks, Reports

**Estimated scope:** Large; split into community and competitions slices

## Task 11: Audit admin and operational workflows

**Description:** Compare admin dashboard, analytics/insights, users, plans, reports,
bug reports, marketing, payments, promotions, and competition organizers. Determine
which workflows should remain web-only before creating mobile work.

**Acceptance criteria:**

- [ ] Every admin route has a product decision: Mobile Required, Read-only Mobile, or Web-only.
- [ ] High-risk mutations include confirmation, audit, and permission requirements.
- [ ] No admin feature is scheduled merely to make route counts equal.

**Verification:** stakeholder approval recorded in `decision-log.md`; role-gate checks with Admin account

**Dependencies:** Tasks 1–3

**Files likely inspected:** Admin, Reports, Bug Reports, Billing, Promotions, Competitions

**Estimated scope:** Medium audit; implementation scope depends on decisions

### Checkpoint: Functional audit complete

- [ ] Every matrix row has evidence and a final status.
- [ ] Partial features list the exact missing fields/actions/states.
- [ ] Intentional differences are approved and documented.
- [ ] No finding is based only on filenames or route counts.

### Phase 3: Convert findings into an executable sync roadmap

## Task 12: Score and prioritize verified gaps

**Description:** Score each verified gap by user impact, workflow criticality,
data/security risk, affected users, implementation effort, dependency count, and
reversibility.

**Acceptance criteria:**

- [ ] P0 contains only broken core workflows, wrong contracts, security/data-loss risks, or release blockers.
- [ ] P1 contains high-value Athlete/Coach parity needed for complete workflows.
- [ ] P2/P3 contain community, competition, admin, and polish work according to product decisions.

**Verification:** priority review with product owner; ties include documented rationale

**Dependencies:** Tasks 4–11

**Files produced:** `tasks/sync-backlog.md`, `tasks/decision-log.md`

**Estimated scope:** Small

## Task 13: Slice the sync backlog into buildable feature increments

**Description:** Convert each approved gap into a vertical task containing API
contract, DTO/entity mapping, provider/repository, native UI, localization, tests,
and runtime verification. Keep each implementation task to at most five likely files;
split larger features.

**Acceptance criteria:**

- [ ] Every task has Given/When/Then acceptance criteria and exact verification commands.
- [ ] Dependencies and safe parallelization groups are explicit.
- [ ] Each release wave leaves mobile buildable and core flows usable.

**Verification:** backlog sizing review; no task remains XL

**Dependencies:** Task 12

**Files produced:** `tasks/sync-backlog.md`

**Estimated scope:** Medium

### Final checkpoint

- [ ] Audit artifacts are complete and reviewed.
- [ ] Product decisions separate true parity gaps from intentional platform differences.
- [ ] P0/P1 implementation backlog is ready for `/build`.
- [ ] Baseline `flutter analyze`, `flutter test`, and debug APK build results are recorded.

## Recommended Implementation Waves After Audit

1. **Wave 0 — Contract corrections:** wrong endpoints, wrong response shapes, owner/client ID defects, permission leaks.
2. **Wave 1 — Core Athlete and Coach journeys:** authentication recovery, plan/workout lifecycle, client coaching, nutrition/cycle data.
3. **Wave 2 — Account and commercial completeness:** deletion verification, subscription/pricing decisions, storage, notifications.
4. **Wave 3 — Engagement:** community feed, challenges, competition discovery and participation.
5. **Wave 4 — Operational scope:** only approved admin/organizer mobile workflows.
6. **Wave 5 — Parity hardening:** accessibility, localization, offline/retry, performance, screenshots, and regression suite.

## Quality Gates for Every Future Sync Task

- Focused regression test written before implementation.
- API path and payload checked against OpenAPI and the web hook.
- Loading, empty, error, refresh, and permission states implemented.
- English and Vietnamese localization verified.
- Phone widths 320/390 and tablet width 768 checked.
- `flutter analyze` has no issues.
- Full `flutter test` passes.
- Debug APK builds successfully.
- Diff contains no unrelated user changes or secrets.

## Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Route-count parity is mistaken for feature parity | High | Audit actions, data, policies, and states at capability level. |
| Web behavior has drifted from backend contract | High | Treat OpenAPI/policies as source of truth and log web defects separately. |
| Combined mobile screens hide missing actions | High | Compare field/action matrices, not page names. |
| Missing role/tier test data creates false conclusions | High | Complete Task 3 before runtime audit. |
| Porting all admin pages creates low-value scope | Medium | Require an explicit product decision for every admin capability. |
| Dirty mobile worktree mixes audit and implementation | Medium | Planning artifacts only during audit; no feature edits until backlog approval. |
| Large domains become unreviewable | Medium | Split Training, Health, Coach, Community, and Competition into vertical slices. |

## Open Decisions

- Should admin payments, promotions, marketing, and organizer management be available on mobile, read-only, or web-only?
- Is mobile file/storage management required, or should files open through native share/download flows only?
- Should public competition discovery be part of the mobile unauthenticated experience?
- Must mobile reproduce the web pricing page, or is the native subscription screen the approved equivalent?
- Which platform is authoritative when web behavior conflicts with OpenAPI or current product rules?

## Approved Addendum — Application-wide Proportional Scaling (5 August 2026)

### Decision

- Use 390 logical pixels as the design-width baseline.
- Scale the complete application canvas by `screenWidth / 390`, clamped to
  `0.90–1.20`.
- Preserve the existing layout structure; do not introduce tablet-specific
  columns, rails, or navigation variants as part of this change.
- Preserve physical safe areas and keyboard insets, and retain the platform's
  accessibility text scaling.

### Implementation slices

1. Add and unit-test the scale calculation and adjusted viewport contract.
2. Integrate the scaling frame at `MaterialApp.router.builder` so routes,
   overlays, dialogs, and sheets share one scale.
3. Run responsive widget regressions at 320, 390, and 468 logical pixels,
   followed by analyzer, full tests, and a debug build.

### Acceptance criteria

- Scale is `0.90` at and below 351px, `1.0` at 390px, and `1.20` at and above
  468px.
- Safe-area and keyboard insets retain their physical rendered size.
- System text accessibility scaling remains active.
- Existing screen layout branching is not changed by new breakpoint code.
