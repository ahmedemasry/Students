import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:students_list/model/sql_controller.dart';
import 'package:students_list/model/student.dart';

class AddStudent extends StatefulWidget {
  Student student;
  AddStudent(this.student);

//  final List<Student> _students;
//  const AddStudent(this._students);
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  SQLController sqlController = SQLController();

  int id;
  int passGroup;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();


  @override
  Widget build(BuildContext context) {
    id = widget.student.id;
    //passGroup = widget.student.pass;
    name.text = widget.student.name;
    description.text = widget.student.description;
    date.text = widget.student.date;


    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Student'),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Passed or not ?', style: TextStyle(fontSize: 20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(value: 1, groupValue: widget.student.pass, onChanged: (value) {
                        setState(() {
                          widget.student.pass = value;
                        });
                      },),

                      Text('Passed'),
                      SizedBox(width: MediaQuery.of(context).size.width*.3,),
                      Radio(value: 2, groupValue: widget.student.pass, onChanged: (value) {
                        setState(() {
                          widget.student.pass = value;
                        });
                      },),
                      Text('Failed'),
                  ],),
                  SizedBox(height: 10,),

                  Text('Name', style: TextStyle(fontSize: 20),),
                  TextField( controller: name,),
                  SizedBox(height: 10,),

                  Text('Description', style: TextStyle(fontSize: 20),),
                  TextField(controller: description,),
                  SizedBox(height: 10,),

                  Text('Date', style: TextStyle(fontSize: 20),),
                  TextField(controller: date,),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Save'),
                        color: Colors.blue,
                        onPressed:(){
                          setState(() {
                            saveStudent(Student(id: id, name: name.text, pass: widget.student.pass, description: description.text, date: date.text));
                          });
                        }
                      ),
                      SizedBox(width: 30,),
                      RaisedButton(
                        child: Text('Delete'),
                        color: Colors.blue,
                        onPressed: (){
                          deleteStudent(Student(id: id));
                        },
                      ),
                    ],
                  )

                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  saveStudent(Student student) async {
    int result;
    Navigator.pop(context);
    print(student.id);
    if(student.id == null)
    {
      result = await sqlController.insertStudent(student);
    }
    else
    {
      result = await sqlController.updateStudent(student);
    }
  }

  deleteStudent(Student student) async {
    int result;
    Navigator.pop(context);
    print(student.id);
    result = await sqlController.deleteStudent(student);
  }
  
}
