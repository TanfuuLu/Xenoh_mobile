# Xenoh Flutter Mobile API Docs

> Purpose: API reference for building the Flutter mobile app with feature parity to the current Xenoh website.
> Source: `Xenoh_fe/src/shared/api/endpoints.ts` and current frontend feature hooks.
> Backend: ASP.NET Core REST API + JWT + SignalR.

## 1. API Conventions

- Base URL comes from environment config.
- All authenticated requests use:

```http
Authorization: Bearer <accessToken>
Content-Type: application/json
```

- Avatar upload uses multipart form data.
- Public endpoints do not require JWT.
- Backend authorization is final. Flutter route guards are only for user experience.
- API errors should be normalized into one mobile failure model using the backend `message` field where available.
- Dates are ISO strings. Date-only route parameters use `YYYY-MM-DD`.
- Language parameters use `en` or `vi`.

## 2. Roles, Tiers, And Shared Enums

### Roles

- `Individual`
- `Coach`
- `Admin`

### Subscription Tiers

- `Free`
- `ProIndividual`
- `ProCoach`

### Common Enums

- `ReportReason`: `Harassment`, `Spam`, `Scam`, `Inappropriate`, `Other`
- `ReportStatus`: `Pending`, `Resolved`, `Dismissed`
- `WebsiteBugReportSeverity`: `Low`, `Medium`, `High`, `Critical`
- `WebsiteBugReportStatus`: `Open`, `InProgress`, `Resolved`, `Dismissed`
- `DayStatus`: `Normal`, `Rest`, `Missed`
- `Gender`: `Male`, `Female`, `Other`
- `DevelopmentDirection`: `Strength`, `Hypertrophy`, `FatLoss`, `Recomposition`, `Endurance`, `GeneralHealth`
- `TrainingDiscipline`: `Powerlifting`, `Bodybuilding`, `Weightlifting`, `Calisthenics`, `CrossFit`, `Running`, `GeneralFitness`
- `RelationshipStatus`: `Pending`, `Active`, `PendingTermination`, `Expired`
- `PlanType`: `Self`, `Coach`
- `MuscleGroup`: `Chest`, `Back`, `Shoulders`, `Biceps`, `Triceps`, `Forearms`, `Abs`, `Glutes`, `Quads`, `Hamstrings`, `Calves`, `FullBody`, `Cardio`, `Traps`, `Neck`, `Adductors`, `Abductors`

## 3. Authentication

### Register

```http
POST /api/auth/register
```

Creates an account. Current business rule: accounts register as `Individual`; coach capability comes from `ProCoach`.

### Login

```http
POST /api/auth/login
```

Returns access token, refresh token, and user/session data.

### Refresh Token

```http
POST /api/auth/refresh-token
```

Mobile behavior:

- Call once after a `401`.
- Store returned tokens securely.
- Retry the original request once.
- If refresh fails, clear local session and route to login.

### Logout

```http
POST /api/auth/logout
```

Revokes the server-side session/token and clears mobile storage.

### Change Password

```http
POST /api/auth/change-password
```

Requires authenticated user.

### Forgot Password

```http
POST /api/auth/forgot-password/send-code
POST /api/auth/forgot-password/reset
```

Use a two-step UI: send reset code, then submit code plus new password.

### External Login

```http
GET  /api/auth/external/{provider}
POST /api/auth/external/exchange
POST /api/auth/external/complete-registration
```

Supported providers from frontend: `google`, `facebook`.

Mobile behavior:

- Open `/api/auth/external/{provider}?client=mobile` in the system browser.
- The backend redirects successful mobile OAuth to
  `xenoh://auth/social-callback?ticket=...`.
- Android and iOS route that callback into `/social-callback`; unrelated
  schemes, hosts, and paths are rejected.
- Exchange ticket with backend.
- Tickets are short-lived and single-use. Duplicate callback delivery must
  share the same exchange request.
- Provider failures return `error=external_login_failed`; never put JWT or
  refresh tokens in the callback URI.
- New social accounts receive the `Individual` role during exchange, so no
  completion form is required by the current contract.

## 4. Users, Profile, Bodyweight, PRs

### Current User

```http
GET /api/users/me
PUT /api/users/me
```

Used for profile display and editing.

Profile fields include:

- First name, last name, email
- Bio
- Avatar URL
- Height
- Gender
- Date of birth
- Development direction
- Training discipline
- Social links: Facebook, Instagram, Zalo
- Current streak, level, XP, title
- Latest bodyweight, BMI, DOTS score

### Preferences

```http
GET /api/users/me/preferences
PUT /api/users/me/preferences
```

Preferences include:

- `language`: `en` or `vi`
- `theme`
- `weightUnit`

Mobile should update local UI immediately, then sync to backend.

### Avatar Upload

```http
POST /api/users/me/avatar
```

Use multipart form data.

### Bodyweight

```http
GET    /api/users/me/bodyweight
POST   /api/users/me/bodyweight
DELETE /api/users/me/bodyweight/{id}
```

Log bodyweight, list history, and delete entries.

### Training Activity

```http
GET /api/users/me/training-activity?year={year}&month={month}
GET /api/users/me/volume-history?months={months}
```

Used for activity calendar and volume charts.

### Exercise PRs

```http
GET /api/users/me/exercise-prs
GET /api/users/me/exercise-prs/{exerciseTemplateId}/history
```

Used for current PRs and per-exercise history.

### Public Profiles

```http
GET /api/users/{userId}
GET /api/users/{userId}/public
GET /api/users/{userId}/bodyweight
```

Use public profile route for community/user-facing profile display.

### Report User

```http
POST /api/users/{userId}/reports
```

Request fields:

- `reason`
- `details`

## 5. Blocks

```http
POST   /api/users/{userId}/block
DELETE /api/users/{userId}/block
GET    /api/users/me/blocks
```

Mobile should optimistically update block/unblock UI only after success or safely rollback on failure.

## 6. Dashboard

```http
GET /api/dashboard/personal
```

Returns the authenticated landing-page data:

- Profile summary
- Active plan
- Current week
- Today workout
- Nutrition summary
- Meal-plan progress
- Next actions
- Pro insight cards

## 7. Plans

### Plan CRUD

```http
GET    /api/plans
GET    /api/plans/{id}
POST   /api/plans
PUT    /api/plans/{id}
DELETE /api/plans/{id}
```

Plan fields include:

- Name
- Start date
- End date
- Plan type: `Self` or `Coach`
- Owner
- Coach creator
- Total/completed weeks and days
- Active state

### Plan Actions

```http
PATCH /api/plans/{id}/activate
PATCH /api/plans/{id}/deactivate
POST  /api/plans/{id}/duplicate
GET   /api/plans/{id}/export
```

`export` returns CSV/downloadable content.

### Coach Plan APIs

```http
GET  /api/plans/coach-overview
POST /api/plans/for-user
```

Requires Coach/ProCoach authorization.

### Plan AI And Analytics

```http
POST /api/plans/starter-ai
GET  /api/plans/{id}/analytics
GET  /api/plans/{id}/design-analysis
POST /api/plans/{id}/balance-check?lang={en|vi}
```

Handle:

- Pro gate
- AI quota exhausted
- Cached result
- Backend AI failure

## 8. Weeks And Days

### Weeks

```http
GET   /api/plans/{planId}/weeks
PATCH /api/plans/{planId}/weeks/{weekId}
```

Used for week list/detail and week rename/update.

### Days

```http
GET   /api/weeks/{weeklyWorkoutId}/days
PATCH /api/days/{dailyWorkoutId}/status
POST  /api/days/{sourceDailyWorkoutId}/copy
POST  /api/days/{dailyWorkoutId}/complete-all
```

Day statuses:

- `Normal`
- `Rest`
- `Missed`

## 9. Exercises And Templates

### Exercises

```http
GET    /api/exercises/by-day/{dailyWorkoutId}
GET    /api/exercises/by-week/{weeklyWorkoutId}
POST   /api/exercises
PUT    /api/exercises/{id}
DELETE /api/exercises/{id}
PATCH  /api/exercises/{id}/skip
PATCH  /api/exercises/by-day/{dailyWorkoutId}/reorder
```

Exercise fields include:

- Template ID
- Name
- Primary and secondary muscle groups
- Exercise kind: `Strength` or `Cardio`
- Planned sets/reps/weight
- Completed sets count
- Skipped/completed state
- Notes
- Sort order
- Personal record weight
- Timer data
- Duration
- Estimated calories
- Image URL

### Sets

```http
PATCH /api/exercises/sets/{setId}/complete
PATCH /api/exercises/sets/{setId}
```

Set completion accepts actual reps, actual weight, and RPE.

### Timers

```http
PATCH /api/exercises/{id}/timer/start
PATCH /api/exercises/{id}/timer/finish
PATCH /api/exercises/{id}/timer/set-duration
```

Mobile should keep a local countdown for UI smoothness and sync server state on start/finish/duration changes.

### Exercise Templates

```http
GET    /api/exercise-templates
GET    /api/exercise-templates/for-client/{clientId}
POST   /api/exercise-templates/custom
PUT    /api/exercise-templates/custom/{id}
DELETE /api/exercise-templates/custom/{id}
POST   /api/exercise-templates/custom/for-client/{clientId}
GET    /api/exercise-templates/{exerciseTemplateId}/last-performance?dailyWorkoutId={dailyWorkoutId}
```

Coach client-specific template endpoints require coach access.

## 10. Comments

### Plan Comments

```http
GET    /api/plans/{planId}/comments
POST   /api/plans/{planId}/comments
DELETE /api/plans/{planId}/comments/{commentId}
```

### Week Comments

```http
GET    /api/weeks/{weekId}/comments
POST   /api/weeks/{weekId}/comments
DELETE /api/weeks/{weekId}/comments/{commentId}
```

Comments also receive SignalR events. Keep list sync by refetching on reconnect.

## 11. Nutrition

### Summary And Profile

```http
GET /api/nutrition/summary
PUT /api/nutrition/profile
```

Nutrition profile fields include:

- Activity level
- Goal: `Cut`, `Maintain`, `Bulk`
- Target weight
- Custom calorie target
- Protein per kg
- Fat per kg

### Daily Logs

```http
GET /api/nutrition/logs/{date}
PUT /api/nutrition/logs/{date}
GET /api/nutrition/history?from={date}&to={date}
```

Daily log fields:

- Calories
- Protein
- Carbs
- Fat
- Notes

### Coach Client Nutrition

```http
GET /api/nutrition/clients/{clientId}/summary
PUT /api/nutrition/clients/{clientId}/profile
GET /api/nutrition/clients/{clientId}/logs/{date}
PUT /api/nutrition/clients/{clientId}/logs/{date}
GET /api/nutrition/clients/{clientId}/history?from={date}&to={date}
```

Requires coach access.

### Foods And Food Logs

```http
GET    /api/nutrition/foods/search?q={query}&lang={en|vi}
GET    /api/nutrition/foods/resolve?name={name}
POST   /api/nutrition/foods
GET    /api/nutrition/logs/{date}/foods
POST   /api/nutrition/logs/{date}/foods
DELETE /api/nutrition/logs/{date}/foods/{id}
```

Custom food fields:

- Vietnamese name
- English name
- Calories/protein/carbs/fat per 100g
- Optional default serving label and grams

Food log fields:

- Food item ID
- Grams, or serving label/count

### Meal Plans

```http
GET  /api/nutrition/meal-plans/{date}
PUT  /api/nutrition/meal-plans/{date}
GET  /api/nutrition/clients/{clientId}/meal-plans/{date}
PUT  /api/nutrition/clients/{clientId}/meal-plans/{date}
POST /api/nutrition/meal-plans/items/{itemId}/check
POST /api/nutrition/meal-plans/items/{itemId}/uncheck
```

Meal plan structure:

- Day
- Meals
- Items
- Planned totals
- Checked totals
- Checked item state

## 12. Cycle Tracking

Cycle tracking is menstrual-cycle tracking and should be shown only when the user profile supports it, currently female-gated in the website.

```http
GET    /api/cycle/overview
GET    /api/cycle/logs?from={date}&to={date}
PUT    /api/cycle/logs/{date}
DELETE /api/cycle/logs/{date}
GET    /api/cycle/settings
PUT    /api/cycle/settings
GET    /api/cycle/day-markers?from={date}&to={date}
GET    /api/cycle/insight?lang={en|vi}
GET    /api/cycle/clients/{clientId}/overview
```

Cycle log fields:

- Flow
- Symptoms
- Mood
- Energy level
- Notes

Cycle settings:

- Average cycle length override
- Average period length override
- Share with coach

## 13. Insights And AI

```http
GET  /api/insights/me?lang={en|vi}
GET  /api/insights/me/coach-tip?lang={en|vi}
POST /api/insights/me/coach-chat
GET  /api/insights/plan/{planId}/progress?lang={en|vi}
```

AI behavior:

- Pro-gated where backend requires it.
- Show cached state when returned.
- Show quota exhausted state.
- Do not silently hide AI failures.

## 14. Coach-Client

### Relationship Management

```http
PUT    /api/coach-client/accept/{relationshipId}
POST   /api/coach-client/{relationshipId}/request-termination
POST   /api/coach-client/{relationshipId}/accept-termination
POST   /api/coach-client/{relationshipId}/reject-termination
```

Termination is client-initiated. The coach can accept or reject only while
the relationship status is `PendingTermination`.

### Coach And Client Lists

```http
GET /api/coach-client/pending-requests
GET /api/coach-client/my-coach
GET /api/coach-client/my-clients
GET /api/coach-client/dashboard
```

### Coach Client Detail APIs

```http
GET /api/coach-client/clients/{clientId}/powerlifting
GET /api/coach-client/clients/{clientId}/ai-brief?lang={en|vi}
```

### Invite Codes

```http
GET    /api/coach-client/invite-codes
POST   /api/coach-client/invite-codes
DELETE /api/coach-client/invite-codes/{id}
POST   /api/coach-client/connect-by-code
```

Invite code generation uses coaching start/end dates.

## 15. Chat And Notifications

### Messages

```http
GET  /api/messages/relationships/{relationshipId}
POST /api/messages/relationships/{relationshipId}
POST /api/messages/relationships/{relationshipId}/read
GET  /api/messages/unread-counts
```

Message fields:

- ID
- Relationship ID
- Sender
- Content
- Kind: `User` or `System`
- Read state
- Created date

### Notifications

```http
GET   /api/notifications
PATCH /api/notifications/{id}/read
PATCH /api/notifications/read-all
```

Notification fields:

- Type
- Message
- Read state
- Related entity ID/type
- Created date

## 16. SignalR Realtime

Connect after login with JWT authentication.

Expected client event handlers:

- `ReceiveMessage`
- `ReceiveNotification`
- `ReceivePlanCommentAdded`
- `ReceivePlanCommentDeleted`
- `ReceiveWeekCommentAdded`
- `ReceiveWeekCommentDeleted`

Reconnect behavior:

- Reconnect automatically.
- Refetch unread counts.
- Refetch notification list.
- Refetch open chat/comment screens.

## 17. Community, Friends, Training-Day Shares

### Community Users

```http
GET /api/community/users?query={query}&page={page}&pageSize={pageSize}
GET /api/community/users/{userId}
GET /api/community/users/{userId}/training-day-shares
```

Search is enabled in the website once the query has at least 2 characters.

### Friends

```http
GET    /api/friends
GET    /api/friends/requests?direction={incoming|outgoing}
POST   /api/friends/requests
POST   /api/friends/requests/{id}/accept
POST   /api/friends/requests/{id}/reject
DELETE /api/friends/{userId}
```

### Training-Day Shares

```http
POST   /api/training-day-shares
GET    /api/training-day-shares/feed
DELETE /api/training-day-shares/{id}
POST   /api/training-day-shares/{id}/love
DELETE /api/training-day-shares/{id}/love
```

Share creation uses:

- Daily workout ID
- Optional caption

## 18. Billing And Subscriptions

```http
GET  /api/subscriptions/me
POST /api/subscriptions/payment-orders
POST /api/subscriptions/dev-activate
```

Subscription response includes:

- Tier
- Active state
- Expiry
- AI quota

Payment order request:

- `requestedTier`: `ProIndividual` or `ProCoach`
- `durationMonths`: `1`, `3`, `6`, or `12`

Payment order response includes:

- Order ID
- Transfer code
- Amount
- Duration
- Requested tier
- Expiry
- Bank account number
- Bank account name
- Bank name
- Transfer description

`dev-activate` is for development/testing only.

## 19. Public Sharing

```http
GET /api/share/pr/{userId}/{exerciseTemplateId}/image.png
```

Public endpoint. Use for PR share image display/native sharing.

## 20. Website Analytics And Bug Reports

### Analytics

```http
POST /api/analytics/page-view
POST /api/analytics/usage
```

For mobile, only implement if backend expects mobile analytics in the same pipeline.

### Website Bug Reports

```http
POST /api/bug-reports
```

Bug report fields:

- Title
- Description
- Page URL/screen identifier
- Browser/device info
- Severity

## 21. Admin

Admin APIs require `Admin`.

### Dashboard And Analytics

```http
GET /api/admin/dashboard
GET /api/admin/insights?from={date}&to={date}&granularity={Day|Month}
GET /api/admin/marketing?from={date}&to={date}&granularity={Day|Month}
GET /api/admin/ai-usage/summary
```

Admin dashboard includes:

- Users
- New users
- Active coaches
- Paid subscriptions
- Pending reports
- Revenue
- Plan/workout metrics

Admin insights include:

- User registrations
- Active users
- Paid subscriptions
- Revenue
- Plans created
- Completed workout days
- Reports
- AI requests
- Community activity

Marketing analytics include:

- Page views
- Sessions
- Known users
- Logins
- Registrations
- Usage seconds
- Top sources/campaigns/referrers/entry pages
- Top flows
- Open bug reports

### Reports

```http
GET   /api/admin/reports
GET   /api/admin/reports/summary
PATCH /api/admin/reports/{id}
```

Review report with:

- Status: `Resolved` or `Dismissed`
- Optional admin note

### Bug Reports

```http
GET   /api/admin/bug-reports?status={status}&severity={severity}
PATCH /api/admin/bug-reports/{id}
```

Review bug report with:

- Status: `InProgress`, `Resolved`, or `Dismissed`
- Optional admin note

### Users

```http
GET  /api/admin/users?search={query}&role={role}&tier={tier}&suspended={bool}
GET  /api/admin/users/{userId}
POST /api/admin/users/{userId}/suspend
POST /api/admin/users/{userId}/unsuspend
PATCH /api/admin/users/{userId}/subscription
```

Subscription adjustment fields:

- Tier
- Duration months or null
- Reason

### Plans

```http
GET /api/admin/plans?planType={type}&ownerId={id}&coachId={id}&from={date}&to={date}&isActive={bool}
GET /api/admin/plans/{planId}/analytics
```

### Payments And Subscriptions

```http
GET /api/admin/payments?status={status}&tier={tier}&from={date}&to={date}
GET /api/admin/payments/summary
GET /api/admin/subscriptions?tier={tier}&active={bool}
```

## 22. Mobile Implementation Checklist

- Build one typed API client per domain.
- Keep DTO enum values exactly matching backend values.
- Use secure storage for tokens.
- Implement refresh-token rotation before feature work.
- Centralize error parsing.
- Centralize Pro/ProCoach/Admin guard helpers.
- Use pull-to-refresh for list screens.
- Disable duplicate mutation submits.
- Refetch visible data after long background/resume.
- Reconnect SignalR on app resume.
- Do not support offline mutations unless a sync queue is explicitly implemented.
