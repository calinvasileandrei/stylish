import 'dart:async';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';

enum CreateClotheEvent { Fetch }

class CreateClotheBloc {

  //StreamControllets
  final _stateStreamController = StreamController<List<String>>();
  StreamSink<List<String>> get _mainSink => _stateStreamController.sink;
  Stream<List<String>> get mainStream => _stateStreamController.stream;

  //EventsStreamControllers
  final _eventStreamController = StreamController<CreateClotheEvent>();
  StreamSink<CreateClotheEvent> get eventSink => _eventStreamController.sink;
  Stream<CreateClotheEvent> get _eventStream => _eventStreamController.stream;

  //Init
  CreateClotheBloc() {
    _eventStream.listen((event) async {
      switch (event) {
        case CreateClotheEvent.Fetch:
          {
            CategoryDao repository = new CategoryDao();
            _mainSink.add(await repository.getAllNamesSortedByPosition());
          }
          break;

      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
