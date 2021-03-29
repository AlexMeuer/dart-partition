import 'package:partition/partition.dart';

void main() {
  final source = Iterable.generate(10, (i) {
    print('Generating $i');
    return i;
  });

  // Partition lazily. Results in two iterations over source.
  var partitioned = source.partition((i) => i.isEven);
  print(partitioned.matching);
  print(partitioned.nonMatching);

  // Partition eagerly. Results in one iteration over source.
  partitioned = source.partition((i) => i.isEven, lazy: false);
  print(partitioned.matching);
  print(partitioned.nonMatching);

  // Shorthand for `lazy: false`.
  partitioned = source.partitionNow((i) => i.isEven);
  // The result is a decorated list, so we don't *have* to use
  // matching/nonMatching getters to access the underlying iterables.
  print(partitioned[0]);
  print(partitioned.last);
}
