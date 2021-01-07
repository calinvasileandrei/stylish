import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/Models/CategoryClothes.dart';
import 'package:stylish/View/HomeView/bloc/HomeState.dart';

enum HomeEvent { Fetch, Init, DeleteAll }

class HomeBloc extends Bloc<HomeEvent,HomeState > {
  final repository;
  List<CategoryClothes> categoryClothes;
  HomeBloc({this.repository}) : super(HomeInitState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event) {
      case HomeEvent.Init:
        yield HomeLoading();
        await repository.hasCategorysInitialized();
        categoryClothes= await repository.getHomeViewCategory();
        yield HomeLoaded(categoriesClothes: categoryClothes);
        break;
      case HomeEvent.Fetch:
        yield HomeLoading();
        categoryClothes= await repository.getHomeViewCategory();
        yield HomeLoaded(categoriesClothes: categoryClothes);
        break;
      case HomeEvent.DeleteAll:
        yield HomeLoading();
        await repository.deleteAll();
        categoryClothes= await repository.getHomeViewCategory();
        yield HomeLoaded(categoriesClothes: categoryClothes);
        break;
    }
  }
}