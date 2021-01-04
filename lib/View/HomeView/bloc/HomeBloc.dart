import 'dart:async';
import 'package:stylish/DB/DataAccessObject/CategoryClotheDao.dart';
import 'package:stylish/Models/CategoryClothes.dart';

enum HomeEvent { Fetch, Init, DeleteAll }

class HomeBloc {
  final _stateStreamController = StreamController<List<CategoryClothes>>();
  StreamSink<List<CategoryClothes>> get _homeSink => _stateStreamController.sink;
  Stream<List<CategoryClothes>> get homeStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<HomeEvent>();
  StreamSink<HomeEvent> get eventSink => _eventStreamController.sink;
  Stream<HomeEvent> get _eventStream => _eventStreamController.stream;

  HomeBloc() {
    _eventStream.listen((event) async {
      switch (event) {
        case HomeEvent.Init:
          {
            CategoryClotheDao repository = new CategoryClotheDao();
            await repository.hasCategorysInitialized();

            final categoryClothesData=await repository.getHomeViewCategory();
            _homeSink.add(categoryClothesData);
          } break;

        case HomeEvent.Fetch:
          {
            CategoryClotheDao repository = new CategoryClotheDao();
            _homeSink.add(await repository.getHomeViewCategory());
          }
          break;

        case HomeEvent.DeleteAll:
          {
            CategoryClotheDao repository = new CategoryClotheDao();
            await repository.deleteAll();
            _homeSink.add(await repository.getHomeViewCategory());
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
