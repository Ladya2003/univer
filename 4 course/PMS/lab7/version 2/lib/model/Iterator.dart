import 'Entities.dart';

class HobbyEntityIterator implements Iterator<HobbyEntity> {
  final List<HobbyEntity> _entities;
  int _currentIndex = -1;

  HobbyEntityIterator(this._entities);

  @override
  HobbyEntity get current => _entities[_currentIndex];

  @override
  bool moveNext() {
    _currentIndex++;
    return _currentIndex < _entities.length;
  }
}

class HobbyEntityCollection extends Iterable<HobbyEntity> {
  final List<HobbyEntity> _entities;

  HobbyEntityCollection(this._entities);

  @override
  Iterator<HobbyEntity> get iterator => HobbyEntityIterator(_entities);
}
