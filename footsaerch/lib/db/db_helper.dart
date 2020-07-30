import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:footsaerch/model/foodmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

final String aa = 'foodSearch';//table name

class DBHelper {
  var _db;

  Future<Database> get database async {

    if ( _db != null ) return _db;

    _db = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'food.db'),//path

      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $aa (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, siteUrl TEXT, imgUrl TEXT, date DATETIME)",
        );
      },
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );
    return _db;
  }

  Future<void> insertFood(FoodModel memo) async {
    final db = await database;

    // food의 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다.
    // 만약 동일한 food의 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.insert(
      aa,
      memo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FoodModel>> foods() async {
    final db = await database;

    // 모든 food의 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query(aa);

    // List<Map<String, dynamic>를 List<Memo>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return FoodModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        siteUrl: maps[i]['siteUrl'],
        imgUrl: maps[i]['imgUrl'],
        date: maps[i]['date'],
      );
    });
  }

  Future<List<FoodModel>> searchFood(String t) async{
    final db = await database;
    print('=============================================================================');
//    final List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM $aa WHERE title");
    final List<Map<String,dynamic>> maps = await db.query(aa, where: "title LIKE ?",whereArgs: ['%$t%'] );
    print(maps.length);
//    return maps;
    return List.generate(maps.length, (i){
      return FoodModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        siteUrl: maps[i]['siteUrl'],
        imgUrl: maps[i]['imgUrl'],
        date: maps[i]['date'],
      );
    });

  }

  Future<void> updateFood(FoodModel memo) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.update(
      aa,
      memo.toMap(),
      // food의 id가 일치하는 지 확인합니다.
      where: "id = ?",
      // Food의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [memo.id],
    );
  }

  Future<void> deleteFood(int id) async {
    final db = await database;
//    deleteDatabase('food.db');
    // 데이터베이스에서 Memo를 삭제합니다.
    await db.delete(
      aa,
      // 특정 food의 제거하기 위해 `where` 절을 사용하세요
      where: "id = ?",
      // food의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );

  }

}
