import 'dart:developer';

import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/DB/DataAccessObject/ClotheDao.dart';
import 'package:stylish/Models/Category.dart';
import 'package:stylish/Models/Clothe.dart';

class CategoryClotheDao {
  Future<Map<String, List<Clothe>>> getHomeViewCategory() async {
    Map<String, List<Clothe>> categorysMap = new Map<String, List<Clothe>>();
    CategoryDao categoryDao = new CategoryDao();
    ClotheDao clotheDao = new ClotheDao();

    List<Category> categorys = await categoryDao.getAllSortedByName();

    categorys.forEach((category) async {
      List<Clothe> clothes = await clotheDao.getClothes(category.clothes);
      categorysMap.putIfAbsent(category.name, () => clothes);
    });

    return categorysMap;
  }

  Future<bool> hasCategorysInitialized() async {
    CategoryDao categoryDao = new CategoryDao();

    int elementsNumber = await categoryDao.countElements();
    log("elements: " + elementsNumber.toString());
    if (elementsNumber > 0) {
      return true;
    } else {
      await categoryDao.initCategory();
      return false;
    }
  }
}
