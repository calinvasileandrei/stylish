import 'dart:developer';

import 'package:sembast/sembast.dart';
import 'package:stylish/DB/AppDatabase.dart';
import 'package:stylish/Models/Category.dart';
import 'package:stylish/Models/Clothe.dart';

class CategoryDao {
  static const String CATEGORY_STORE_NAME = 'category';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _categoryStore = intMapStoreFactory.store(CATEGORY_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Category category) async {
    await _categoryStore.add(await _db, category.toMap());
  }

  Future update(Category category) async {
    final finder = Finder(filter: Filter.byKey(category.id));
    await _categoryStore.update(await _db, category.toMap(), finder: finder);
  }

  Future delete(Category category) async {
    final finder = Finder(filter: Filter.byKey(category.id));
    await _categoryStore.delete(await _db, finder: finder);
  }

  Future<bool> deleteAllCategory() async {
    List<Category> allCategories = await getAllSortedByName();
    try{
      allCategories.forEach((category) async {
        await delete(category);
      });
      return true;
    }catch (e){
      return false;
    }
  }

  Future<Category> getByName(String categoryName) async {
    final finder = Finder(filter: Filter.equals("name",categoryName));
    final recordSnapshot =
        await _categoryStore.findFirst(await _db, finder: finder);
    if(recordSnapshot != null && recordSnapshot.value != null) {
      var category = Category.fromMap(recordSnapshot.value);
      category.id = recordSnapshot.key;
      return category;
    }
  }

  Future<List<Category>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [SortOrder('name')]);

    final recordSnapshots =
        await _categoryStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final category = Category.fromMap(snapshot.value);
      category.id = snapshot.key;
      return category;
    }).toList();
  }

  Future<List<String>> getAllCategoriesNames() async {
    final finder = Finder();

    final recordSnapshots =
    await _categoryStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final category = Category.fromMap(snapshot.value);
      return category.name;
    }).toList();
  }

  Future<int> countElements() async {
    return await _categoryStore.count(await _db);
  }

  Future initCategory() async {
    Category categoryHats = new Category("Hats", new List<int>());
    Category categoryTshirts = new Category("Tshirts/Vests", new List<int>());
    Category categoryTrousers = new Category("Trousers", new List<int>());
    Category categoryShoes = new Category("Shoes", new List<int>());
    Category categoryAccessories = new Category("Accessories", new List<int>());

    await insert(categoryHats);
    await insert(categoryTshirts);
    await insert(categoryTrousers);
    await insert(categoryShoes);
    await insert(categoryAccessories);
  }
}
