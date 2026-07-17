# Xenoh Flutter Mobile App Guide

> Purpose: implementation context for Codex or Flutter engineers building a native Xenoh mobile app.
> Source: Xenoh frontend routes/features and product feature documentation.
> Target: Flutter mobile app for iOS and Android backed by the existing Xenoh ASP.NET Core API.

## Product Goal

Xenoh mobile is a focused training and coaching app for lifters, clients, coaches, and admins.

The mobile app must prioritize:

- Fast workout execution in the gym.
- Clear plan review and workout logging.
- Nutrition logging and daily targets.
- Progress tracking with readable charts.
- Coach-client communication and attention signals.
- Subscription-gated Pro and ProCoach workflows.

Do not build the app like a resized desktop dashboard. Build it as a native mobile workflow with thumb-friendly navigation, persistent session context, safe-area support, and offline-tolerant UI states where useful.

## Backend Contract

Use the existing Xenoh backend API.

- Auth: JWT access token + refresh-token rotation.
- API style: REST JSON.
- Realtime: SignalR for chat, comments, and notifications.
- Roles: `Individual`, `Coach`, `Admin`.
- Tiers: `Free`, `ProIndividual`, `ProCoach`.
- Coach features require both `Coach` role and active `ProCoach` tier.
- Pro features must show locked state and route to subscription.

Do not move business logic into Flutter. The backend remains authoritative for auth, authorization, subscriptions, role grants, AI quotas, plan rules, and relationship state.

## Recommended Flutter Structure

Use feature-first Clean Architecture on the client.

```text
lib/
  main.dart
  app/
    xenoh_app.dart
    router.dart
    theme.dart
    app_shell.dart
  core/
    api/
      api_client.dart
      auth_interceptor.dart
      token_store.dart
    config/
    errors/
    localization/
    realtime/
    storage/
    widgets/
  features/
    auth/
      data/
      domain/
      presentation/
    dashboard/
    plans/
    workouts/
    nutrition/
    progress/
    coach_client/
    chat/
    notifications/
    community/
    profile/
    billing/
    cycle/
    insights/
    admin/
```

Feature folder pattern:

```text
feature/
  data/
    models/
    repositories/
    data_sources/
  domain/
    entities/
    repositories/
    use_cases/
  presentation/
    screens/
    widgets/
    controllers/
```

Keep shared widgets in `core/widgets` only when reused across multiple features.

## Flutter Packages

Use stable, common packages only when justified.

- Routing: `go_router`
- HTTP: `dio`
- Secure tokens: `flutter_secure_storage`
- Local preferences: `shared_preferences`
- State: `flutter_riverpod` or `bloc`
- Models: `freezed` + `json_serializable`
- Forms: Flutter form widgets with validators, or `reactive_forms` if complex forms justify it
- Charts: `fl_chart`
- Realtime: SignalR-compatible Dart client
- Images/cache: `cached_network_image`
- Intl/i18n: Flutter localization with English and Vietnamese

Do not introduce alternative backend-facing technologies.

## Design System

Match Xenoh’s current warm training-journal identity.

Core colors:

```dart
const xenohClay900 = Color(0xFF6E4F3A);
const xenohClay800 = Color(0xFF8F6F56);
const xenohClay700 = Color(0xFFA98B76);
const xenohClay600 = Color(0xFFBFA28C);
const xenohSand    = Color(0xFFF3E4C9);
const xenohSage    = Color(0xFFBABF94);
const xenohPaper   = Color(0xFFFFFDF8);
const xenohInk900  = Color(0xFF3A2A1E);
```

UI tone:

- Warm paper backgrounds.
- Clay primary actions.
- Sage success/progress states.
- Warm ink text.
- No emoji in product UI.
- Use icons for actions.
- Sentence case labels.
- Compact, calm, readable screens.

Typography:

- Use a readable serif/sans pairing if available.
- Body text must stay readable on small screens.
- Numeric training values should use tabular numerals where possible.

## App Navigation

Use role-aware shell navigation.

### Individual Bottom Tabs

- Dashboard
- Plans
- Community
- Progress
- More

### Coach Bottom Tabs

- Overview
- Plans
- Community
- Clients
- More

### Admin Bottom Tabs

- Dashboard
- Marketing
- Users
- Bugs
- More

The More screen contains:

- Profile
- Exercise library
- Nutrition
- Cycle, only when relevant
- Subscription
- Coach profile or enter coach code
- Settings
- Blocklist
- Change password
- Logout

Coach More also contains:

- Chat
- Key vault

Admin More also contains:

- Insights
- Reports
- Plans
- Payments

## Global Mobile UX Rules

- Respect safe areas on iOS and Android.
- Primary actions should be reachable with one thumb.
- Use bottom sheets for compact create/edit flows.
- Use full-screen dialogs for long forms like AI starter plan or nutrition profile.
- Use pull-to-refresh on list-heavy screens.
- Use skeletons/loading states for first load.
- Use inline retry for failed sections.
- Avoid horizontal scrolling except charts with clear gestures.
- Large destructive actions require confirmation dialogs.
- Long names, emails, exercise names, and Vietnamese text must wrap safely.
- Always implement empty, loading, error, locked, and unauthorized states.

## Feature Screens

### Auth

Screens:

- Login
- Register
- Forgot password
- Social callback / external registration completion

Requirements:

- Register creates an Individual account only.
- Store access/refresh tokens securely.
- Refresh token automatically before authenticated requests fail.
- Logout must call backend logout and clear secure storage.
- Forms must show field-level errors.

### Dashboard

Screen: Dashboard tab.

Content:

- Greeting and today date.
- Today workout card.
- Active plan card.
- Level, streak, bodyweight, DOTS metrics.
- Nutrition today summary.
- Meal plan preview.
- AI insight shortcut for Pro.
- Plate calculator shortcut.

Mobile layout:

- Today workout is first actionable card.
- Metrics use 2-column grid.
- Secondary panels stack vertically.
- AI/Pro locked items show upgrade state without blocking core workflow.

### Plans

Screens:

- Plans list
- Plan detail
- Plan overview
- Week detail
- Week analysis
- Create/duplicate plan
- AI starter plan

Requirements:

- Separate self plans and coach-assigned plans.
- Coaches can create plans for active clients.
- Free users have plan limits; paid users have expanded access.
- Plan actions: activate, deactivate, duplicate, export if supported, delete.

Mobile layout:

- Plan cards show name, dates, owner/type, active status, progress.
- Plan actions should be secondary menu items if space is tight.
- Week/day navigation uses compact cards or horizontal day strip.

### Workout Execution

Screen: Daily workout.

This is the highest-priority mobile workflow.

Content:

- Back navigation.
- Set progress count.
- Session summary bar.
- Exercise cards.
- Set rows.
- RPE and actual values.
- Rest/exercise timers.
- Add/edit/reorder/skip/delete exercise.
- Mark day as rest or missed.
- Complete workout.
- Copy day.
- Daily result summary.

Mobile layout:

- Keep workout progress visible near the top.
- Exercise cards stack vertically.
- Set rows must be large and tappable.
- Complete set interaction should be one or two taps.
- Timer controls must be visible inside each exercise.
- Reordering should use explicit drag handles and fallback up/down controls.
- Add/edit forms should open as bottom sheets or full-screen dialogs.
- Complete workout result should show volume, duration, RPE, warnings, and estimated calories.

### Exercise Library

Screens:

- Exercise library
- Custom exercise create/edit
- Last performance lookup

Mobile layout:

- Search at top.
- Muscle group filters as chips or dropdown.
- Exercise rows show name, muscle group, kind, custom/global marker.
- Create/edit custom exercises in a bottom sheet.

### Nutrition

Screens:

- Nutrition dashboard
- Food log
- Food search
- Custom food
- Meal plan calendar
- Nutrition profile settings
- Nutrition insight
- Coach client nutrition

Content:

- BMR, TDEE, calorie target, bodyweight.
- Macro progress.
- Food log per day.
- Weekly meal plan.
- History and Pro analysis.

Mobile layout:

- Daily targets and food log first.
- Food search should be fast and keyboard-friendly.
- Quantity picker must be thumb-friendly.
- Weekly meal plan should become a vertical day list if calendar grid is cramped.
- Coach client view may be read-only where backend rules require it.

### Progress

Screens:

- Progress overview
- Powerlifting Big 3
- Plan analytics
- PR history
- Leaderboard, if included
- AI progress insight

Mobile layout:

- Plan/client selectors at top.
- Tabs for overview and powerlifting.
- Metric cards before charts.
- Charts stack vertically.
- Use readable axis labels and compact legends.
- Empty states for no plan, no client, or no history.

### Coach and Client Management

Screens:

- Coach profile
- Enter coach code
- Clients dashboard
- Client detail
- Client today workout
- Key vault invite codes
- Relationship renewal/termination flows
- Client AI insight

Mobile layout:

- Client list cards prioritize name, attention level, plan progress, last workout, contract dates.
- Attention badges must include text.
- Pending requests show Accept and Decline full-width buttons.
- Key vault invite codes show copy action and expiry/status.
- Client detail uses tabs or sections: Overview, Training, Nutrition, Progress, Chat.

### Chat

Screens:

- Coach chat hub
- Client coach chat
- Conversation screen

Realtime:

- Use SignalR for new messages and unread counts.
- Reconnect gracefully.
- Mark read when conversation is viewed.

Mobile layout:

- Contact list and conversation are separate screens.
- Conversation has sticky composer above keyboard/safe area.
- Message list scrolls independently.
- Show unread badges capped at `9+`.
- Provide empty state when no active coach/client relationship exists.

### Notifications

Screens:

- Notification center
- Notification badge/bell

Mobile layout:

- Notifications list uses cards/rows.
- Show unread state, event type, timestamp, and route target.
- Actions: mark read, mark all read.
- Realtime updates through SignalR.

### Community

Screens:

- Community feed
- Friends
- Public user profile
- Shared training day

Mobile layout:

- Feed first.
- Discovery/friend suggestions below feed or in a separate tab.
- Training share cards show author, date, workout summary, metrics, and friend action.
- Public profile shows training identity, stats, and report/block actions.

### Profile and Settings

Screens:

- My profile
- Edit profile
- Avatar upload
- Bodyweight log
- PR history
- Activity calendar
- Preferences
- Change password
- Blocklist

Mobile layout:

- Profile summary at top.
- Stats in 2-column grid.
- Bodyweight and PR history as list rows.
- Activity calendar uses compact heatmap.
- Preferences use native switches, segmented controls, and pickers.

### Cycle

Screens:

- Cycle dashboard
- Cycle day log
- Cycle settings
- Cycle insight
- Coach client cycle

Mobile layout:

- Show only for relevant profiles.
- Phase guidance first.
- Calendar compact and tappable.
- Trends below guidance.
- Day log uses large controls and clear save action.

### Insights and AI

Screens:

- Personal insights
- AI coach chat
- Plan design analysis
- Balance check
- Nutrition insight
- Cycle insight
- Coach client AI brief

Rules:

- Show locked state for Free users.
- Show quota exhaustion state when backend returns quota errors.
- AI output must be readable, wrapped, and sectioned.
- Do not expose API keys or AI provider details in the app.

### Billing and Subscription

Screens:

- Current subscription
- Pricing
- Payment order
- Payment confirmation/instructions

Mobile layout:

- Current plan appears first.
- Pricing cards stack.
- Purchase CTA full-width.
- Payment order modal/screen shows amount, provider instructions, and expiry clearly.
- Tier switch warnings require confirmation.

### Admin

Screens:

- Dashboard
- Insights
- Marketing
- Reports
- Bugs
- Users
- Plans
- Payments

Mobile layout:

- Admin data tables become list cards.
- Filters open as bottom sheets.
- State-changing actions require confirmation.
- Admin is lower priority than workout, coach, nutrition, and progress flows.

## State Management

Use a consistent approach across features.

Recommended with Riverpod:

- `FutureProvider` / `AsyncNotifier` for server-backed state.
- Repository classes for API calls.
- Immutable models generated from JSON.
- Central auth provider for token/user/session.
- Central subscription provider for tier gates.
- Realtime providers for SignalR connection, chat unread counts, and notifications.

Do not call `Dio` directly from widgets. Widgets call controllers/providers.

## API Error Handling

Handle these cases explicitly:

- 401: refresh token, retry once, otherwise logout.
- 403: show unauthorized or subscription-required state.
- 404: show not found.
- 409: show conflict message for relationship/subscription/plan state.
- Validation errors: map to form fields.
- Network unavailable: show retry and preserve local form input.

## Offline and Poor Network Behavior

Minimum:

- Keep form input while requests are pending or failed.
- Show retry actions.
- Disable duplicate submission.
- Cache profile, dashboard, plans, and last loaded workout in memory during session.

Optional later:

- Local draft workout logs.
- Queue set completions offline.
- Sync conflict resolution.

Do not implement offline mutation queues unless product explicitly approves the complexity.

## Localization

Support:

- English
- Vietnamese

Rules:

- No hardcoded user-facing strings in widgets.
- Vietnamese strings are longer; all buttons and tabs must handle wrapping/truncation.
- Dates and numbers should use locale-aware formatting.
- Weight unit preference must be respected.

## Accessibility

- Use semantic labels for icon buttons.
- Respect system text scaling where possible.
- Ensure color contrast on warm backgrounds.
- Do not rely on color alone for status.
- Form fields need labels and error text.
- Dialogs need clear titles and dismiss actions.

## Build Checklist

Before shipping each feature:

- Test on small Android width, standard iPhone width, large phone, and tablet.
- Test light/dark preference if implemented.
- Test English and Vietnamese.
- Test loading, empty, error, locked, and unauthorized states.
- Test keyboard overlap on forms and chat composer.
- Test bottom navigation safe area.
- Test token refresh and logout.
- Test SignalR reconnect for chat and notifications.
- Test destructive action confirmations.

