/// Splits [value] into sentence-like bullets on `.`/`!`/`?` boundaries,
/// treating a following whitespace/end-of-string as the sentence end so
/// decimals (`63.5`) or day/month counts (`4/21`) don't get split mid-way.
/// Returns an empty list for null/blank input.
List<String> splitIntoSentences(String? value) {
  final text = value?.trim();
  if (text == null || text.isEmpty) return const [];

  final bullets = <String>[];
  final buffer = StringBuffer();
  final chars = text.runes.map(String.fromCharCode).toList();
  for (var i = 0; i < chars.length; i += 1) {
    final char = chars[i];
    buffer.write(char);
    final next = i + 1 < chars.length ? chars[i + 1] : '';
    if ((char == '.' || char == '!' || char == '?') &&
        (next.isEmpty || next.trim().isEmpty)) {
      final sentence = buffer.toString().trim();
      if (sentence.isNotEmpty) bullets.add(sentence);
      buffer.clear();
    }
  }

  final remainder = buffer.toString().trim();
  if (remainder.isNotEmpty) bullets.add(remainder);
  return bullets;
}
