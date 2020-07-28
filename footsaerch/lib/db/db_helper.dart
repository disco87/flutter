import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:footsaerch/model/foodmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class DBHelper{
  var db;

  final String TABLE = 'foodSearch';
  final String DBNAME = 'foodSearchRecipe';
  final String ID = 'id';
  final String TITLE = 'title';
  final String IMGURL = 'imgUrl';
  final String SITEURL = 'siteUrl';
  final String DATE = 'date';

  static Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }
  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String myPath = join(documentsDirectory.path, DBNAME);
    return await openDatabase(
      myPath,
      version: 1,
      onCreate: (db, version) {
        db.execute("CREATE TABLE $TABLE ($ID INTEGER AUTOINCREMENT PRIMARY KEY, $TITLE TEXT,$IMGURL TEXT, $SITEURL TEXT, $DATE TEXT)");

      },
    );
  }

  //insert
  createFoodData(FoodModel fm) async{
    final db = await database;
    var res = await db.insert(TABLE, fm.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FoodModel>> foodAllRead() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE);//table name

    return List.generate(maps.length, (index) {
     return FoodModel(
       id : maps[index][ID],
       title: maps[index][TITLE],
       imgUrl: maps[index][IMGURL],
       siteUrl: maps[index][SITEURL],
       date:  maps[index][DATE],
     );
    });

  }

  deleteFood(int id) async{
    final db = await database;
    await db.delete(TABLE, where: 'id =?', whereArgs: [id]);

  }

}