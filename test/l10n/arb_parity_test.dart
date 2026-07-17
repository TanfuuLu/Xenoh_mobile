import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('English and Vietnamese ARB files expose the same message keys', () {
    final en = _messageKeys('lib/l10n/app_en.arb');
    final vi = _messageKeys('lib/l10n/app_vi.arb');

    expect(vi.difference(en), isEmpty, reason: 'Unexpected Vietnamese keys');
    expect(en.difference(vi), isEmpty, reason: 'Missing Vietnamese keys');
  });
}

Set<String> _messageKeys(String path) {
  final data =
      jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return data.keys.where((key) => !key.startsWith('@')).toSet();
}
