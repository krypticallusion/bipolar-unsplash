import 'dart:async';

class LazyLoading {
  final _streamController = StreamController<bool>.broadcast();
  get stream =>  _streamController.stream;
  Function(bool) get changeLoadStatus => _streamController.sink.add;

  dispose() {
    _streamController.close();
  }
}

final LazyLoading lazyLoader = LazyLoading();