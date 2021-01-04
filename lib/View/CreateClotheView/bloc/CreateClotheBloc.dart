import 'dart:async';
import 'package:stylish/DB/DataAccessObject/CategoryClotheDao.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/Models/CategoryClothes.dart';

enum CreateClotheEvent { Fetch }

class CreateClotheBloc {
  final _stateStreamController = StreamController<List<String>>();
  StreamSink<List<String>> get _mainSink => _stateStreamController.sink;
  Stream<List<String>> get mainStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CreateClotheEvent>();
  StreamSink<CreateClotheEvent> get eventSink => _eventStreamController.sink;
  Stream<CreateClotheEvent> get _eventStream => _eventStreamController.stream;

  CreateClotheBloc() {
    _eventStream.listen((event) async {
      switch (event) {
        case CreateClotheEvent.Fetch:
          {
            CategoryDao repository = new CategoryDao();
            _mainSink.add(await repository.getAllCategoriesNames());
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
