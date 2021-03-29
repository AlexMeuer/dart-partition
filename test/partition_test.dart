import 'package:partition/partition.dart';
import 'package:test/test.dart';

void main() {
  test('separates lists correctly', () {
    final result = Iterable<int>.generate(10).partition((i) => i.isEven);
    expect(result.length, 2);
    expect(result.matching.length, 5);
    expect(result.nonMatching.length, 5);
    expect(result.matching, [0, 2, 4, 6, 8]);
    expect(result.nonMatching, [1, 3, 5, 7, 9]);
  });

  test('returns empty results when partitioning an empty source', () {
    final result = Iterable<int>.empty().partition((i) => i.isEven);
    expect(result.length, 2);
    expect(result.matching, []);
    expect(result.nonMatching, []);
  });

  group('when lazy = true,', () {
    test('partitioning does not happen immediately', () {
      final source = Iterable<int>.generate(
        1,
        (_) => throw TestFailure('Partitioning was not lazy!'),
      );

      final result = source.partition((i) => i.isEven);
      expect(result.length, 2);
    });

    test('source iteration happens every time a result is iterated', () {
      var iterationCount = 0;
      final source = Iterable<int>.generate(10, (i) {
        if (i == 9) {
          ++iterationCount;
        }
        return i;
      });

      final result = source.partition((i) => i.isEven);
      expect(result.length, 2);
      expect(result.matching.length, 5);
      expect(result.nonMatching.length, 5);
      expect(result.matching, [0, 2, 4, 6, 8]);
      expect(result.nonMatching, [1, 3, 5, 7, 9]);
      expect(iterationCount, 4);
    });
  });

  group('when lazy = false,', () {
    test('partitioning happens immediately', () {
      var iterationCount = 0;
      final source = Iterable<int>.generate(10, (i) {
        if (i == 9) {
          ++iterationCount;
        }
        return i;
      });

      final result = source.partition((i) => i.isEven, lazy: false);
      expect(result.length, 2);
      expect(iterationCount, 1);
    });

    test('source iteration happens only ever once', () {
      var iterationCount = 0;
      final source = Iterable<int>.generate(10, (i) {
        if (i == 9) {
          ++iterationCount;
        }
        return i;
      });

      final result = source.partition((i) => i.isEven, lazy: false);
      expect(result.length, 2);
      expect(result.matching.length, 5);
      expect(result.nonMatching.length, 5);
      expect(result.matching, [0, 2, 4, 6, 8]);
      expect(result.nonMatching, [1, 3, 5, 7, 9]);
      expect(iterationCount, 1);
    });
  });
}
