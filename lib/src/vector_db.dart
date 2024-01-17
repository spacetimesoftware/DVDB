import 'collection.dart';
import 'errors.dart';

class VectorDB {
  VectorDB._internal();

  static final VectorDB _shared = VectorDB._internal();
  final Map<String, Collection> _collections = {};

  static VectorDB get shared => _shared;

  Collection collection(String name) {
    if (_collections.containsKey(name)) {
      return _collections[name]!;
    }

    final Collection collection = Collection(name);
    _collections[name] = collection;
    collection.load();
    return collection;
  }

  Collection? getCollection(String name) {
    return _collections[name];
  }

  void releaseCollection(String name) {
    _collections.remove(name);
  }

  void reset() {
    for (final Collection collection in _collections.values) {
      collection.clear();
    }
    _collections.clear();
  }
}