import 'package:go_survey/models/database/gosurveydatabase.dart';
import 'package:sqflite/sqflite.dart';

class CrudOperation {
  late GoSruveyDataBase _databaseConnection;
  CrudOperation() {
    _databaseConnection = GoSruveyDataBase();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table,
        where: 'id=?', whereArgs: [itemId], limit: 1);
  }

  readDataLogin(table, emailUser, passwordUser) async {
    var connection = await database;
    return await connection?.query(table,
        where: 'email=? AND password=?',
        whereArgs: [emailUser, passwordUser],
        limit: 1);
  }

  readDataByContraints(table, champ, champValue) async {
    var connection = await database;
    return await connection
        ?.query(table, where: '$champ =?', whereArgs: [champValue]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}