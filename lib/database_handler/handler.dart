import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../model/add_employee.dart';
import '../model/employee_auth_model.dart';

class DBHandler
{
  static Database? _db;
  Future<Database?> get db async
  {
    if(_db != null)
      {
        return _db;
      }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async
  {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'addEmployee.db');
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async
  {
    await db.execute('CREATE TABLE add_employee (id INTEGER  PRIMARY KEY AUTOINCREMENT, employeeName TEXT NOT NULL, employeeNumber TEXT UNIQUE)');
    await db.execute('CREATE TABLE employee_authentication (id INTEGER  PRIMARY KEY AUTOINCREMENT, employeeName TEXT NOT NULL, employeeNumber TEXT, employeeImage TEXT NOT NULL , employeeAuthDate TEXT NOT NULL, employeeAuthTime TEXT NOT NULL, authStatus TEXT NOT NULL)');
  }

  Future<bool> isEmployeeNumberExist(String employeeNumber, String table) async {
    var dbClient = await db;
    final List<Map<String, Object?>>? result = await dbClient?.query(
      table,
      where: 'employeeNumber = ?',
      whereArgs: [employeeNumber],
    );

    return result!.isNotEmpty;
  }
  Future<bool> inUserExist(String employeeNumber , String employeeName) async {
    var dbClient = await db;
    final List<Map<String, Object?>>? result = await dbClient?.query(
      'add_employee',
      where: 'employeeName = ? AND employeeNumber = ?',
      whereArgs: [employeeName, employeeNumber],
    );

    return result!.isNotEmpty;
  }

  Future<AddEmployee> insert(AddEmployee addEmployee) async
  {
    var dbClient = await db;
    await dbClient?.insert('add_employee', addEmployee.toMap());
    return addEmployee;
  }

  Future<EmployeeAuthModel> employeeAuthInsertion(EmployeeAuthModel employeeAuthModel) async
  {
    var dbClient = await db;
    await dbClient?.insert('employee_authentication', employeeAuthModel.toMap());
    return employeeAuthModel;
  }


  Future<List<AddEmployee>> getEmployeeList (String table) async
  {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(table);
    return queryResult.map((e) => AddEmployee.fromMap(e)).toList();
  }

  Future<List<EmployeeAuthModel>> getEmployeeAuthRecord (String table) async
  {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(table);
    return queryResult.map((e) => EmployeeAuthModel.fromMap(e)).toList();
  }

  Future<List<AddEmployee>> searchEmployees(String keyword) async {
    final search = await db;
    List<Map<String, dynamic>> allRows = await search!.query(
      'add_employee',
      where: 'employeeName LIKE ?',
      whereArgs: ['%$keyword%'],
    );
    List<AddEmployee> employees =
    allRows.map((employee) => AddEmployee.fromMap(employee)).toList();
    return employees;
  }

  Future<void> clearEmployeeTable() async {
    var dbClient = await db;
    await dbClient?.delete('add_employee');
    print('Clear');
  }

}