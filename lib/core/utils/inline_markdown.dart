import 'package:flutter/widgets.dart';

/// Renders the small subset of Markdown the AI responses actually use, so
/// `**bold**` / `***bold italic***` / `*italic*` display as styled text instead
/// of literal asterisks. Leading list markers (`- ` / `* `) at the start of a
/// line become a `• ` bullet. Everything else passes through verbatim.
///
/// Emphasis spans set only weight/style, so they cascade onto the base style of
/// the enclosing [TextSpan] (color, size, height are inherited).
List<InlineSpan> inlineMarkdownSpans(String text) {
  final normalised = text
      .split('\n')
      .map((line) {
        // Headers (`#`..`######`) become a bold line.
        final header = RegExp(r'^\s*#{1,6}\s+(.*)$').firstMatch(line);
        if (header != null) {
          return '**${header.group(1)}**';
        }
        // List markers become a bullet glyph.
        final bullet = RegExp(r'^(\s*)[-*]\s+').firstMatch(line);
        if (bullet != null) {
          return '${bullet.group(1)}• ${line.substring(bullet.end)}';
        }
        return line;
      })
      .join('\n');

  final pattern = RegExp(
    r'\*\*\*(.+?)\*\*\*|\*\*(.+?)\*\*|\*(.+?)\*',
    dotAll: true,
  );

  final spans = <InlineSpan>[];
  var index = 0;
  for (final match in pattern.allMatches(normalised)) {
    if (match.start > index) {
      spans.add(TextSpan(text: normalised.substring(index, match.start)));
    }
    if (match.group(1) != null) {
      spans.add(
        TextSpan(
          text: match.group(1),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    } else if (match.group(2) != null) {
      spans.add(
        TextSpan(
          text: match.group(2),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      );
    } else {
      spans.add(
        TextSpan(
          text: match.group(3),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      );
    }
    index = match.end;
  }
  if (index < normalised.length) {
    spans.add(TextSpan(text: normalised.substring(index)));
  }
  return spans;
}
