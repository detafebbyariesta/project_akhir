import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/item.dart';
import '../model/itemKopsis.dart';


class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
//untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'Kopsis.db';
//create, read databases
    var kopsisDatabase = openDatabase(path,
        version: 11,
        onCreate: _createDb,
        onUpgrade:
            _onUpgrade); //mengembalikan nilai object sebagai hasil dari fungsinya
    return kopsisDatabase;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    _createDb(db, newVersion);
  }

//buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    var batch = db.batch();
    await batch.execute('DROP TABLE IF EXISTS item');
    await batch.execute('DROP TABLE IF EXISTS itemKopsis');

//membuat tabel item
    await batch.execute('''

    CREATE TABLE item (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama TEXT,
    namaBarang TEXT,
    price INTEGER,
    stok INTEGER,
    kodeBarang INTEGER
    )
    ''');
//membuat tabel itemKopsis
    await batch.execute('''
    
    CREATE TABLE itemKopsis (
    idKopsis INTEGER PRIMARY KEY AUTOINCREMENT,
    namaKopsis TEXT,
    tanggal TEXT
    )
    ''');
    await batch.commit();
  }

//select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('item', orderBy: 'namaBarang');
    return mapList;
  }

//select databases
  Future<List<Map<String, dynamic>>> selectKopsis() async {
    Database db = await this.initDb();
    var mapList = await db.query('itemKopsis', orderBy: 'namaKopsis');
    return mapList;
  }

//create databases
  Future<int> insert(Item object) async {
    Database db = await this.initDb();
    int count = await db.insert('item', object.toMap());
    return count;
  }

//create databases
  Future<int> insertKopsis(ItemKopsis object) async {
    Database db = await this.initDb();
    int count = await db.insert('itemKopsis', object.toMap());
    return count;
  }

//update databases
  Future<int> update(Item object) async {
    Database db = await this.initDb();
    int count = await db.update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update databases
  Future<int> updateKopsis(ItemKopsis object) async {
    Database db = await this.initDb();
    int count = await db.update('itemKopsis', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

//delete databases
  Future<int> deleteKopsis(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('itemKopsis', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //mengembalikan data yang sudah dimasukkan pada tabel item
  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Item> itemList = List<Item>();
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMap(itemMapList[i]));
    }
    return itemList;
  }

//mengembalikan data yang sudah dimasukkan pada tabel itemKopsis
  Future<List<ItemKopsis>> getItemKopsisList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<ItemKopsis> itemList = List<ItemKopsis>();
    for (int i = 0; i < count; i++) {
      itemList.add(ItemKopsis.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
