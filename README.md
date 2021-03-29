# Partition - split iterables based on predicates

[![Pub](https://img.shields.io/badge/pub-1.0.0-informational)](https://pub.dev/packages/partition)
[![Style: Pedantic](https://img.shields.io/badge/style-pedantic-blue)](https://pub.dev/packages/pedantic)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FAlexMeuer%2Fdart-partition.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2FAlexMeuer%2Fdart-partition?ref=badge_shield)

## Splits one list into two; no more, no less.

But how?

```dart
final source = Iterable<int>.generate(10);
final result = source.partition((i) => i.isEven);
print(result.matching); // [ 0, 2, 4, 6, 8 ]
print(result.nonMatching); // [ 1, 3, 5 ,7 ,9 ]
```

By default, partitioning will happen lazily. This means that every time you access either `matching` or `nonMatching` (even to check the length), it will iterate over the entire source iterable.

To partition eagerly (and only iterate over the source _once_):

```dart
final source = Iterable<int>.generate(10);
final result = source.partition((i) => i.isEven, lazy: false);
// alteratively: final result = source.partitionNow((i) => i.isEven);
print(result.matching); // [ 0, 2, 4, 6, 8 ]
print(result.nonMatching); // [ 1, 3, 5 ,7 ,9 ]
```
The `PartitionResult` that is returned is just a `List<Iterable<T>>` with a fixed length of 2, where the first element is an `Iterable` (or `List` if partitioning was eager) of all the elements that matched the predicate, and where the second iterable contains all the elements that did not match the predicate.

The `PartitionResult` will _always_ have a length of 2, even if you tried to partition an empty source iterable or if nothing/everything matched the predicate.

## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FAlexMeuer%2Fdart-partition.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2FAlexMeuer%2Fdart-partition?ref=badge_large)