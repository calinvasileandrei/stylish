import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stylish/DB/DataAccessObject/CategoryClotheDao.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/DB/DataAccessObject/ClotheDao.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Models/CategoryClothes.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/View/HomeView/Components/ListCategoryBuilder.dart';
import 'package:stylish/View/HomeView/bloc/HomeBloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeBloc = new HomeBloc();

  @override
  void initState() {
    //TODO: remove below line only for debug
    //homeBloc.eventSink.add(HomeEvent.DeleteAll);
    homeBloc.eventSink.add(HomeEvent.Init);
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    log("disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeBloc.eventSink.add(HomeEvent.Fetch);
    return StreamBuilder<List<CategoryClothes>>(
        stream: homeBloc.homeStream,
        builder: (context, AsyncSnapshot<List<CategoryClothes>> snapshot) {
          if (snapshot.hasData) {
            return StylishSkeleton(
              subtitle: "Choose your outfit",
              child: ListCategoryBuilder(categoryClothes: snapshot.data),
            );
          } else if (snapshot.hasError) {
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
