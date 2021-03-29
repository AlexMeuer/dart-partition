import 'package:partition/src/iterable_extensions.dart';

/// Split a single iterable into two iterables based on the given predicate.
/// When [lazy] is false: partitioning is performed eagerly, the source
/// iterable is iterated over once, and two [List]s are returned.
/// When [lazy] is true: then two lazy iterables are returned, each of which
/// will iterate over the source iterable.
List<Iterable<T>> partition<T>(
  Iterable<T> source,
  bool Function(T) predicate, {
  bool lazy = true,
}) =>
    source.partition(predicate, lazy: lazy);
