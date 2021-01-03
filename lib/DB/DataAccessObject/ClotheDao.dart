import 'package:sembast/sembast.dart';
import 'package:stylish/DB/AppDatabase.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/Models/Category.dart';
import 'package:stylish/Models/Clothe.dart';

class ClotheDao {
  static const String CLOTHE_STORE_NAME = 'clothe';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  final _clotheStore = intMapStoreFactory.store(CLOTHE_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Clothe clothe) async {
    //add the new clothe
    await _clotheStore.add(await _db, clothe.toMap());

    //get the category for that clothe
    CategoryDao categoryDao = new CategoryDao();
    Category category = await categoryDao.getByName(clothe.category);

    //add the new clothe to the category list of ids
    category.addNewClothe(clothe.id);

    //update the category on db with the new data
    categoryDao.update(category);
  }

  Future update(Clothe clothe) async {
    final finder = Finder(filter: Filter.byKey(clothe.id));
    await _clotheStore.update(await _db, clothe.toMap(), finder: finder);
  }

  Future<Clothe> getClothe(int clotheId) async {
    final finder = Finder(filter: Filter.byKey(clotheId));
    final recordSnapshot =
        await _clotheStore.findFirst(await _db, finder: finder);
    return Clothe.fromMap(recordSnapshot.value);
  }

  Future<List<Clothe>> getClothes(List<int> clothesIds) async {
    List<Clothe> clothes = new List();
    clothesIds.forEach((id) async {
      clothes.add(await getClothe(id));
    });

    return clothes;
  }

  Future delete(Clothe clothe) async {
    //delete the clothe
    final finder = Finder(filter: Filter.byKey(clothe.id));
    await _clotheStore.delete(await _db, finder: finder);

    //delete the clothe from the category
    CategoryDao categoryDao = new CategoryDao();
    Category category = await categoryDao.getByName(clothe.category);
    //delete the actual clotheid form list
    category.removeClothe(clothe.id);

    //update the category on db
    categoryDao.update(category);
  }

  Future<List<Clothe>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [SortOrder('name')]);

    final recordSnapshots = await _clotheStore.find(await _db, finder: finder);

    return recordSnapshots.map((snapshot) {
      final clothe = Clothe.fromMap(snapshot.value);
      clothe.id = snapshot.key;
      return clothe;
    }).toList();
  }
}
