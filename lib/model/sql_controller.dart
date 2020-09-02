import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:students_list/model/student.dart';


class SQLController{

  static SQLController sqlController;
  static Database _database;
  SQLController._createInstance();

  factory SQLController(){
    if(sqlController == null)
      {
        sqlController = SQLController._createInstance();
      }
    return sqlController;
  }

  String tableName = "students_table";
  String _id = "id";
  String _name = "name";
  String _description = "description";
  String _pass = "pass";
  String _date = "date";

  Future<Database> get database async{
    if(_database == null)
      {
        _database = await _initializeDatabase();
      }
    return _database;
  }


  Future<Database> _initializeDatabase() async
  {
    Directory dir =  await getApplicationDocumentsDirectory();
    String path = dir.path + 'students.db';
    var studentDB = await openDatabase(path, version: 1, onCreate: createTable);
    return studentDB;
  }
  FutureOr<void> createTable(Database db, int version) async
  {
    await db.execute("CREATE TABLE $tableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT, $_name TEXT, $_description TEXT, $_date TEXT, $_pass INTEGER )");
  }

  Future<List<Map<String, dynamic>>> getStudentsMapList() async
  {
    Database db = await this.database;
    return await db.query(tableName,orderBy: '$_id ASC');
  }
  Future<List<Student>> getStudentsList() async
  {
    List<Map<String,dynamic>> mapList = await getStudentsMapList();
    List<Student> students = new List<Student>();
    for(int i = 0; i < mapList.length; i++)
    {
      students.add(Student.fromMap(mapList[i]));
    }
    return students;
  }


  Future<int> insertStudent(Student student) async
  {
    Database db = await this.database;
    var result = await db.insert(tableName, student.toMap());
    return result;
  }
  Future<int> updateStudent(Student student) async
  {
    Database db = await this.database;
    var result = await db.update(tableName, student.toMap(), where: '$_id = ?', whereArgs: [student.id]);
    return result;
  }
  Future<int> deleteStudent(Student student) async
  {
    Database db = await this.database;
    var result = await db.delete(tableName, where: '$_id = ?', whereArgs: [student.id]);
    return result;
  }
  Future<int> getCount() async
  {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT COUNT (*) FROM $tableName');
    return Sqflite.firstIntValue(result);
  }








}