import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'base_event.dart';

abstract class BaseBloc{
  StreamController<BaseEvent> _eventStreamController = StreamController<BaseEvent>();
  Sink<BaseEvent> get event => _eventStreamController.sink;
  BaseBloc()
  {
    _eventStreamController.stream.listen((event) {
      if(event is ! BaseEvent)
        {
          throw Exception("Event khong hop le");
        }
      dispatchEvent(event);
    });
  }
  void dispatchEvent(BaseEvent baseEvent);

  @mustCallSuper
  void dispose()
  {
    _eventStreamController.close();
  }
}