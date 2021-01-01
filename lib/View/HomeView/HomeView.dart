import 'package:flutter/material.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/View/HomeView/Components/ListCategoryBuilder.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Map<String, List<Clothe>> categorys;

  @override
  void initState() {
    super.initState();

    Clothe exClothe = new Clothe("Tshirt", "10", "", "", "", "Tshirts");
    List<Clothe> tshirtList = new List<Clothe>();
    tshirtList.add(exClothe);
    tshirtList.add(exClothe);
    tshirtList.add(exClothe);

    categorys = {
      "tshirt": tshirtList,
      "pants": tshirtList,
      "shoes": tshirtList
    };
  }

  @override
  Widget build(BuildContext context) {
    return StylishSkeleton(
      subtitle: "Choose your outfit",
      child: ListCategoryBuilder(categorys),
    );
  }
}
