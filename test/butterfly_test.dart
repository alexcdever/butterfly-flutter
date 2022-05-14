import 'package:butterfly_flutter/butterfly.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get id generator', () {
    var generator = Butterfly(DateTime.now().millisecondsSinceEpoch, 0, 0, 0);
    expect(generator.generate().toString().length, 19);
  });

  test('test batch generate', () {
    var generator = Butterfly(DateTime.now().millisecondsSinceEpoch, 0, 0, 0);
    int count = 10;
    List<int> ids = generator.batchGenerate(count);
    Set<int> set = {}..addAll(ids);
    expect(set.length, count);
  });
}
