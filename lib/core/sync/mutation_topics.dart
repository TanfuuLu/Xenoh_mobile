import 'data_topic.dart';

const _mutatingMethods = {'POST', 'PUT', 'PATCH', 'DELETE'};

/// POST endpoints under `/plans` that *read* (AI analysis) rather than write.
///
/// These are fetched from inside providers, so treating them as mutations
/// would bump a topic those same providers watch — an endless request loop.
const _planReadOnlyPosts = {'balance-check'};

/// The topics a successful `method path` request invalidates.
///
/// Deliberately an allowlist: an unmapped path syncs nothing. That keeps
/// unknown endpoints (auth, AI analysis, telemetry) from triggering refetch
/// storms, at the cost of having to add a rule when a new endpoint ships.
Set<DataTopic> topicsForMutation({
  required String method,
  required String path,
}) {
  if (!_mutatingMethods.contains(method.toUpperCase())) return const {};

  var segments = path
      .split('?')
      .first
      .split('#')
      .first
      .split('/')
      .where((segment) => segment.isNotEmpty)
      .toList(growable: false);
  // Absolute URLs carry the API base path; the rules below are written
  // against the relative paths the data sources use.
  if (segments.isNotEmpty && segments.first == 'api') {
    segments = segments.sublist(1);
  }
  if (segments.isEmpty) return const {};

  bool has(String segment) => segments.contains(segment);
  String at(int index) => index < segments.length ? segments[index] : '';

  switch (segments.first) {
    case 'plans':
      if (_planReadOnlyPosts.contains(at(2))) return const {};
      if (has('comments')) return const {DataTopic.community};
      // A coach building a plan for a client.
      if (at(1) == 'for-user') {
        return const {DataTopic.training, DataTopic.coaching};
      }
      return const {DataTopic.training};

    case 'weeks':
      if (has('comments')) return const {DataTopic.community};
      return const {DataTopic.training};

    case 'days':
    case 'exercises':
      return const {DataTopic.training};

    case 'exercise-templates':
      return const {DataTopic.exerciseLibrary, DataTopic.training};

    case 'nutrition':
      if (at(1) == 'clients') {
        return const {DataTopic.nutrition, DataTopic.coaching};
      }
      return const {DataTopic.nutrition};

    case 'supplements':
      if (at(1) == 'clients') {
        return const {DataTopic.supplements, DataTopic.coaching};
      }
      return const {DataTopic.supplements};

    case 'cycle':
      return const {DataTopic.cycle};

    case 'users':
      if (at(1) == 'me') {
        if (at(2) == 'bodyweight') {
          return const {DataTopic.bodyweight, DataTopic.profile};
        }
        return const {DataTopic.profile};
      }
      if (has('block')) return const {DataTopic.community};
      return const {};

    case 'friends':
    case 'community':
      return const {DataTopic.community};

    case 'training-day-shares':
      // Copying a shared day writes exercises into the viewer's own plan.
      if (has('copy')) {
        return const {DataTopic.community, DataTopic.training};
      }
      return const {DataTopic.community};

    case 'coach':
    case 'coach-client':
      return const {DataTopic.coaching};

    case 'messages':
      return const {DataTopic.messages};

    case 'notifications':
      return const {DataTopic.notifications};

    case 'files':
      return const {DataTopic.storage};

    case 'competition-management':
    case 'competitions':
    case 'events':
    case 'organizers':
      return const {DataTopic.competitions};

    case 'subscription':
    case 'subscriptions':
      return const {DataTopic.subscription};

    case 'admin':
      if (has('organizers')) {
        return const {DataTopic.admin, DataTopic.competitions};
      }
      if (has('subscription')) {
        return const {DataTopic.admin, DataTopic.subscription};
      }
      return const {DataTopic.admin};

    case 'bug-reports':
      return const {DataTopic.admin};

    default:
      return const {};
  }
}
