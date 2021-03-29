import 'package:collection/collection.dart';

class PartitionResult<T> extends NonGrowableListView<Iterable<T>> {
  PartitionResult(List<Iterable<T>> base)
      : assert(base.length == 2),
        super(base);

  Iterable<T> get matching => first;
  Iterable<T> get nonMatching => last;
}
