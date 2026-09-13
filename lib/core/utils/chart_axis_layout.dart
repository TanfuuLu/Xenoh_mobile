/// Selects evenly distributed axis-label indexes for the available width.
///
/// Both endpoints are retained so the displayed range stays unambiguous. Dense
/// series are thinned instead of allowing adjacent labels to overlap.
List<int> visibleChartTickIndexes({
  required int itemCount,
  required double availableWidth,
  required double minLabelSpacing,
}) {
  if (itemCount <= 0) return const [];
  if (itemCount == 1) return const [0];

  final safeWidth = availableWidth.isFinite && availableWidth > 0
      ? availableWidth
      : 0.0;
  final safeSpacing = minLabelSpacing.isFinite && minLabelSpacing > 0
      ? minLabelSpacing
      : 1.0;
  final maxVisible = (safeWidth / safeSpacing).floor().clamp(2, itemCount);
  if (maxVisible >= itemCount) {
    return [for (var index = 0; index < itemCount; index++) index];
  }

  final lastIndex = itemCount - 1;
  final segmentCount = maxVisible - 1;
  return [
    for (var segment = 0; segment <= segmentCount; segment++)
      (lastIndex * segment / segmentCount).round(),
  ];
}
