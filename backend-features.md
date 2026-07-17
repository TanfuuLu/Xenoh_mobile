# Xenoh Flutter Mobile Feature Parity Spec

## Summary

Build the Flutter app as a native mobile equivalent of the current Xenoh website.

Source parity is based on:

- `E:\Xenoh\Xenoh_fe\src\app\Router.tsx`
- `E:\Xenoh\Xenoh_fe\src\shared\api\endpoints.ts`
- `E:\Xenoh\docs\xenoh-feature-description.md`

Do not omit newer website modules:

- Community
- Friends
- Training-day shares
- Cycle tracking
- Website bug reports
- Admin insights
- Admin marketing analytics

## Roles And Access

Support these roles:

- `Individual`
- `Coach`
- `Admin`

Support these subscription tiers:

- `Free`
- `ProIndividual`
- `ProCoach`

Rules:

- Pro features require `ProIndividual` or `ProCoach`.
- Coach features require active `ProCoach`.
- Admin features require `Admin`.
- Flutter guards are UX-only; backend authorization remains final.
- Support English/Vietnamese language preference.
- Support theme preference.
- Support kg/lb weight preference.

## Required Features

### Public

- Landing page
- About page
- Pricing page
- Privacy policy
- Terms
- Refund policy

### Authentication

- Register
- Login
- JWT refresh
- Logout
- Forgot password
- Reset password by code
- Change password
- Google/Facebook social login
- Social login callback
- Complete registration after social login when required

### App Shell

- Role-aware navigation
- Mobile bottom tabs
- Drawer/menu for secondary routes
- Notification bell
- Global coach chat tab
- Account menu
- Report bug modal

### Dashboard

- User profile summary
- Current streak
- Level and XP
- User title
- Active plan summary
- Current week summary
- Today workout shortcut
- Nutrition targets/logged values
- Meal-plan progress
- Next actions
- Pro insights

### Profile

- View/edit name, bio, height, gender, date of birth
- Edit development direction
- Edit training discipline
- Edit social links
- Upload avatar
- Manage preferences
- Log bodyweight
- View/delete bodyweight history
- View training activity
- View PR list/history
- Public profile view

### Blocks And Reports

- Block user
- Unblock user
- View blocklist
- Report user with reason:
  - `Harassment`
  - `Spam`
  - `Scam`
  - `Inappropriate`
  - `Other`

### Community

- Search users
- View community profiles
- Send friend request
- Accept/reject friend request
- Remove friend
- View friends
- View incoming/outgoing requests
- Community feed
- User training-day shares
- Love/unlove shares
- Delete own share

### Plans

- List plans
- Create/edit/delete plans
- Activate/deactivate plans
- Duplicate plans
- Export CSV
- Coach-created plans for clients
- Coach plan overview
- Plan detail
- Plan overview
- Week list/detail
- Rename week
- Plan comments
- Week comments

### Plan AI And Analytics

- AI starter plan
- Plan analytics
- Design analysis
- Balance check
- Plan progress insight
- Language-aware AI results
- Cached AI result display
- AI quota exhausted state
- Upgrade state
- Backend failure state

### Workout Execution

- Daily workout screen
- Day status:
  - `Normal`
  - `Rest`
  - `Missed`
- Complete all
- Copy day
- Add/edit/delete/reorder exercises
- Skip/unskip exercise
- Complete set with reps/weight/RPE
- Update set plan
- Rest timer start/finish/set duration
- Last performance lookup
- Session summary

### Exercise Library

- Global templates
- Custom templates
- Coach client-specific templates
- Strength/cardio exercise kinds
- Primary/secondary muscle groups
- Exercise images when provided

### Nutrition

- Nutrition profile
- Activity level
- Goal:
  - `Cut`
  - `Maintain`
  - `Bulk`
- Calorie/macros calculation
- Daily log
- History
- Food search/resolve
- Custom foods
- Add/delete food logs
- Meal plans by date
- Meal-plan meals/items
- Check/uncheck meal items
- Coach client nutrition

### Nutrition AI

- User nutrition insight
- Client nutrition insight
- Pro/ProCoach gate
- AI quota handling

### Cycle Tracking

- Female-gated cycle page
- Cycle overview
- Daily logs
- Symptoms
- Mood
- Flow
- Energy
- Notes
- Delete log
- Settings
- Share-with-coach setting
- Day markers on plans
- AI cycle insight
- Coach client cycle overview

### Progress

- Bodyweight trend
- Plan analytics
- Weekly compliance
- Weekly volume
- Muscle volume/balance/heatmap
- Training score
- Training insights
- Big 3 powerlifting
- DOTS
- PR timelines
- Client powerlifting

### Insights

- Personal AI analysis
- Daily coach tip
- AI coach chat
- Cached result display
- Language choice
- Quota exhausted state
- Upgrade state

### Coach And Client

- My coach profile
- Enter invite code
- Generate/list/delete invite codes
- Coach dashboard
- Client list
- Attention levels/reasons
- Pending requests
- Accept relationship
- Request/accept/reject termination
- Request/accept/reject renewal
- Client profile
- Client today workout
- Client AI brief
- Client nutrition
- Client cycle overview

### Chat And Realtime

- Relationship chat history
- Send messages
- Mark read
- Unread counts
- User/system messages
- SignalR events:
  - `ReceiveMessage`
  - `ReceiveNotification`
  - `ReceivePlanCommentAdded`
  - `ReceivePlanCommentDeleted`
  - `ReceiveWeekCommentAdded`
  - `ReceiveWeekCommentDeleted`
- Reconnect/refetch behavior

### Notifications

- Notification list
- Unread badge
- Mark one read
- Mark all read
- Navigate from notification when related entity exists

### Billing

- Current subscription
- AI quota
- Pricing for `ProIndividual` and `ProCoach`
- Durations:
  - `1`
  - `3`
  - `6`
  - `12`
- Create SePay payment order
- Show:
  - Bank account number
  - Bank account name
  - Bank name
  - Amount
  - Transfer code
  - Transfer description
  - Expiry
- Refresh subscription after payment

### Sharing

- Public PR image endpoint
- Native share link/image where possible
- Training-day share cards in community

### Admin

- Dashboard KPIs
- Insights analytics
- Marketing analytics
- Reports moderation
- Bug reports moderation
- Users list/detail/search/filter
- Suspend/unsuspend users
- Manual subscription adjustment
- Plans list/analytics/filter
- Payments list/summary/filter
- Subscriptions list/filter
- AI usage summary/top users

## API And State Contracts

- Use existing REST endpoints from `ENDPOINTS`.
- Do not invent backend routes unless a website feature cannot be fulfilled.
- Store tokens securely.
- Implement one-time retry token refresh.
- Clear session when refresh fails.
- Connect SignalR after login.
- Preserve backend enum values exactly.
- Backend authorization is final.

## Test Plan

Verify:

- Every website route has a Flutter screen or native equivalent.
- Every frontend endpoint has a Flutter client method.
- Free, ProIndividual, ProCoach, and Admin flows work.
- Auth and token refresh work.
- Plan creation works.
- Workout completion works.
- Nutrition logging works.
- Meal-plan checking works.
- Coach invite/connect works.
- Chat realtime works.
- Plan/week comments realtime work.
- Notifications realtime work.
- Payment order creation works.
- Admin moderation works.

Test edge states:

- Empty data
- Forbidden
- Subscription required
- AI quota exhausted
- Expired token
- Offline/slow network
- SignalR reconnect

## Assumptions

- Flutter consumes the existing .NET backend.
- Flutter uses the existing REST API, SignalR hubs, JWT auth, and SePay payment flow.
- Backend remains the source of truth for permissions and subscription state.
- Push notifications are excluded unless backend mobile push support is added.