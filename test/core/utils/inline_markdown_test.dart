import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/inline_markdown.dart';

/// Flattens the parsed spans into (text, bold, italic) tuples for assertions.
List<({String text, bool bold, bool italic})> _segments(String input) {
  return [
    for (final span in inlineMarkdownSpans(input))
      if (span is TextSpan)
        (
          text: span.text ?? '',
          bold: span.style?.fontWeight == FontWeight.w700,
          italic: span.style?.fontStyle == FontStyle.italic,
        ),
  ];
}

void main() {
  group('inlineMarkdownSpans', () {
    test('passes plain text through as a single unstyled span', () {
      final segments = _segments('just plain text');
      expect(segments, hasLength(1));
      expect(segments.single.text, 'just plain text');
      expect(segments.single.bold, isFalse);
      expect(segments.single.italic, isFalse);
    });

    test('renders **bold** without the asterisks', () {
      final segments = _segments('keep loads **steady** now');
      expect(segments.map((s) => s.text).join(), 'keep loads steady now');
      final bold = segments.firstWhere((s) => s.text == 'steady');
      expect(bold.bold, isTrue);
      expect(bold.italic, isFalse);
    });

    test('renders *italic* and ***bold italic***', () {
      final italic = _segments('a *soft* word').firstWhere(
        (s) => s.text == 'soft',
      );
      expect(italic.italic, isTrue);
      expect(italic.bold, isFalse);

      final both = _segments('a ***strong*** word').firstWhere(
        (s) => s.text == 'strong',
      );
      expect(both.bold, isTrue);
      expect(both.italic, isTrue);
    });

    test('converts a markdown header line into a bold line', () {
      final segments = _segments('## Coach tip');
      expect(segments.map((s) => s.text).join(), 'Coach tip');
      expect(segments.any((s) => s.text == 'Coach tip' && s.bold), isTrue);
    });

    test('converts leading list markers into bullet glyphs', () {
      expect(_segments('- first item').first.text, startsWith('• first item'));
      expect(
        _segments('* second item').first.text,
        startsWith('• second item'),
      );
    });
  });
}
