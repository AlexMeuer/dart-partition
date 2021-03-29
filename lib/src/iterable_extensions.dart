import 'package:partition/src/partition_result.dart';

extension IterableX<T> on Iterable<T> {
  /// Split a single iterable into two iterables based on the given predicate.
  /// When [lazy] is false: partitioning is performed eagerly, the source
  /// iterable is iterated over once, and two [List]s are returned.
  /// When [lazy] is true: then two lazy iterables are returned, each of which
  /// will iterate over the source iterable.
  PartitionResult<T> partition(
    bool Function(T) predicate, {
    bool lazy = true,
  }) {
    if (lazy) {
      return PartitionResult([
        where(predicate),
        where((item) => !predicate(item)),
      ]);
    }

    return partitionNow(predicate);
  }

  /// Split a single iterable into two lists based on the given predicate.
  /// Only iterates over the source iterable once, and always returned two
  /// lists.
  PartitionResult<T> partitionNow(bool Function(T) predicate) {
    final a = <T>[];
    final b = <T>[];

    for (final item in this) {
      (predicate(item) ? a : b).add(item);
    }

    return PartitionResult([a, b]);
  }
}
