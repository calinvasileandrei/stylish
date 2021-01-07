import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/Models/CategoryClothes.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/View/HomeView/Components/ListCategoryBuilder.dart';
import 'package:stylish/View/HomeView/bloc/HomeState.dart';
import 'package:stylish/View/HomeView/bloc/HomeBloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _loadsData();
  }

  _loadsData() async {
    BlocProvider.of<HomeBloc>(context).add(HomeEvent.Init);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (_, HomeState state) {
      if (state is HomeLoaded) {
        List<CategoryClothes> categoriesData = state.categoriesClothes;
        return StylishSkeleton(
          subtitle: "Choose your outfit",
          child: ListCategoryBuilder(categoryClothes: categoriesData),
        );
      } else if (state is HomeError) {
        return StylishSkeleton(
          subtitle: "Choose your outfit",
          child: Center(child: Text("Something went wrong! Ops!")),
        );
      } else {
        return StylishSkeleton(
          subtitle: "Choose your outfit",
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
