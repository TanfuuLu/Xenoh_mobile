String trainingRouteLocation(
  String path, {
  bool coachView = false,
  bool coachPlan = false,
  String? clientId,
}) {
  final scopedClientId = clientId?.trim();
  if (!coachView &&
      !coachPlan &&
      (scopedClientId == null || scopedClientId.isEmpty)) {
    return path;
  }
  return Uri(
    path: path,
    queryParameters: {
      if (coachView) 'coachView': 'true',
      if (scopedClientId != null && scopedClientId.isNotEmpty)
        'clientId': scopedClientId,
      if (coachPlan) 'coachPlan': 'true',
    },
  ).toString();
}
