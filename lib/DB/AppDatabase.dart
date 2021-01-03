//we need a singleton instance, the db is opened only once
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  //Singleton instance
  static final AppDatabase _singleton = AppDatabase._();
  static final _dbName = "stylish.db";

  //Singleton public get
  static AppDatabase get instance => _singleton;

  //Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  //privare constructor for singleton
  AppDatabase._();

  //Database public get
  Future<Database> get database async {
    //if dbOpener.. is null no instance exists so the db is not opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      //calling _openDatabase will complete the completer with the database instance
      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();

    final dbPath = join(appDocumentDir.path, _dbName);

    final database = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter.complete(database);
  }
}
