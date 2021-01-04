import 'dart:developer';

import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/DB/DataAccessObject/ClotheDao.dart';
import 'package:stylish/Models/Category.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Models/CategoryClothes.dart';

class CategoryClotheDao {
  Future<List<CategoryClothes>> getHomeViewCategory() async {
    List<CategoryClothes> categorysClothesList = new List<CategoryClothes>();
    CategoryDao categoryDao = new CategoryDao();
    ClotheDao clotheDao = new ClotheDao();

    List<Category> categorys = await categoryDao.getAllSortedByName();

    categorys.forEach((category) async {
      List<Clothe> clothes = await clotheDao.getClothes(category.clothes);
      categorysClothesList
          .add(new CategoryClothes(category: category.name, clothes: clothes));
    });

    return categorysClothesList;
  }

  Future<bool> hasCategorysInitialized() async {
    CategoryDao categoryDao = new CategoryDao();

    int elementsNumber = await categoryDao.countElements();
    if (elementsNumber > 0) {
      return true;
      log("no category init");
    } else {
      await categoryDao.initCategory();
      log("category init");
      return false;
    }
  }
}
