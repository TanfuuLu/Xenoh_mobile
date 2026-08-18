/// Coarse-grained buckets of server-owned data.
///
/// Every screen-facing provider declares the topics it reads from (via
/// `ref.syncOn(...)`), and every mutating request is mapped to the topics it
/// writes to (see `topicsForMutation`). When a mutation succeeds, the matching
/// topics are bumped and *all* providers reading them re-fetch — so adding or
/// deleting data on one screen refreshes every other screen that shows related
/// data, without the user pulling to refresh.
///
/// Keep this list coarse. A topic per endpoint would be precise but unusable;
/// the cost of an extra re-fetch is far lower than the cost of stale UI.
enum DataTopic {
  /// Plans, weeks, days, exercises, sets, and workout completion.
  training,

  /// The custom exercise-template library.
  exerciseLibrary,

  /// Nutrition profile, food logs, and meal plans.
  nutrition,

  /// Supplement regimens and dose logs.
  supplements,

  /// Menstrual-cycle logs and settings.
  cycle,

  /// Bodyweight log entries.
  bodyweight,

  /// The signed-in user's profile, avatar, and preferences.
  profile,

  /// Feed, shares, kudos, comments, friends, blocks, community settings.
  community,

  /// Coach ↔ client relationships, invite codes, and client-scoped data.
  coaching,

  /// Direct-message threads.
  messages,

  /// The notification feed.
  notifications,

  /// Competitions, registrations, and organizer management.
  competitions,

  /// Uploaded files and file shares.
  storage,

  /// Subscription and billing state.
  subscription,

  /// Admin-console data.
  admin,
}
