import 'package:core/common/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Encrypt should return ecrypted text', () {
    expect(encrypt('Halo'), 'Q43vgyzNlPZ3P8REqHaGvA==');
  });
}
