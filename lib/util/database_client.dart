import 'dart:io';
import 'package:no_to_do_app/model/nodo_item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class DatabaseHelper {

  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = "nodoTbl";
  final String columnId = "id";
  final String columnItemName = "itemName";
  final String columnDateCreated= "dateCreated";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "notodo_db.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }


  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnItemName TEXT, $columnDateCreated TEXT)");
      print("Table is created");
  }

  //CRUD -CREATE - READ-UPDATE -DELETE

//insertion
  Future<int> saveItem(NoDOItem item) async {
    var dbClient = await db;
    //it's int because de database return 1 or 0
    int res = await dbClient.insert("$tableName", item.toMap());

    return res;
  }
  //get

  Future<List> getItems() async {
    var dbClient = await _db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnItemName ASC");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await _db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName "));
  }
  Future<NoDOItem> getItem(int id) async {
    var dbClient = await _db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id ");

    if( result.length == 0) return null;

    return new NoDOItem.fromMap(result.first);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(tableName, where:"$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateUser( NoDOItem item) async {
    var dbClient = await _db;
    return await dbClient.update(tableName, item.toMap(), where: "$columnId =?", whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await _db;
    return dbClient.close();
  }
}