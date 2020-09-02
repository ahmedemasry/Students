import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:students_list/model/sql_controller.dart';
import 'package:students_list/model/student.dart';
import 'package:students_list/screens/add_screen.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StudentsList();
  }
}


class StudentsList extends StatefulWidget {

  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {

  List<Student> _students;
  SQLController sqlController = SQLController();

  @override
  Widget build(BuildContext context) {
    if(_students == null)
    {
      _students = new List<Student>();
    }
    updateListView();

    return Scaffold(
      appBar: AppBar(
        title: Text('Students List'),
      ),
      body:  Center(
        child: getStudentsListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudent(Student(id: null)),));
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _passedAvatar(int pass) {
    return CircleAvatar(
      backgroundColor: pass==Student.PASS ? Colors.green : Colors.red,
      foregroundColor: Colors.white,
      child: Icon(
          pass==Student.PASS ? Icons.check : Icons.close,
      ),
    );
  }

  Future<List<Student>> fetchStudents() async
  {
    Future<List<Student>> students;
    students.then((value) => value.add(Student(id: 2, date: '6-8-2017', description: 'Director', name: 'Mohamed Abdou', pass: Student.PASS)));
    _students.add(Student(id: 2, date: '6-8-2017', description: 'Director', name: 'Mohamed Abdou', pass: Student.PASS));
    print('3 seconds passed');
    return students;

//    _students = await sqlController.getStudentsList();
  }

  Widget getStudentsListView()
  {
    return ListView.builder(
      itemCount: _students.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
              title: Text(this._students[index].name),
              subtitle: Text(this._students[index].description + ' | ' + this._students[index].date),
              leading: _passedAvatar(this._students[index].pass),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStudent(_students[index]),));
              },
            ),
          );
        },
    );
  }

   void updateListView() {
     final Future<Database> db = sqlController.database;
     db.then((database) {
       Future<List<Student>> students = sqlController.getStudentsList();
       students.then((theList) {
         setState(() {
           this._students = theList;
         });
       });
     });
   }
}
