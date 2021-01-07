import 'package:equatable/equatable.dart';
import 'package:stylish/Models/CategoryClothes.dart';

abstract class HomeState extends Equatable{
  @override
  List<Object> get props =>[];
}

class HomeInitState extends HomeState{}

class HomeLoading extends HomeState{}

class HomeLoaded extends HomeState{
  final List<CategoryClothes> categoriesClothes;
  HomeLoaded({this.categoriesClothes});
}

class HomeError extends HomeState{
  final error;
  HomeError({this.error});
}