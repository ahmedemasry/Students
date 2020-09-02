import 'package:flutter/material.dart';
import 'package:students_list/model/sql_controller.dart';
import 'package:students_list/screens/add_screen.dart';
import 'package:students_list/widgets/students_list.dart';

import 'model/student.dart';

void main() {
//  SQLController sqlController = SQLController();
//  print(sqlController);
//  WidgetsFlutterBinding.ensureInitialized();
//  sqlController.insertStudent(Student(id: null, pass: Student.PASS, name: 'Ahmed ElMasry', description: 'Developer',date: '12-6-2020'));
//  sqlController.insertStudent(Student(id: 2, date: '6-8-2017', description: 'Director', name: 'Mohamed Abdou', pass: Student.PASS));
//  sqlController.insertStudent(Student(id: 3, date: '4-6-2019', description: 'Marketer', name: 'Aziz Wageh', pass: Student.FAIL));
//  sqlController.insertStudent(Student(id: 4, date: '8-7-2018', description: 'Musician', name: 'Hossam Ismail', pass: Student.PASS));
//  sqlController.insertStudent(Student(id: 5, date: '1-6-2020', description: 'Designer', name: 'Ibrahem Mohamed', pass: Student.FAIL));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students App',
      initialRoute: '/',
      routes: {
        '/' : (context) => MyHomePage(),
      },
    );
  }
}


