class Student {
  static const PASS = 1;
  static const FAIL = 2;
  int _id;
  String _name;
  String _description;
  String _date;
  int _pass;

  Student({int id, String name, String description, String date, int pass}) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._date = date;
    this._pass = pass;
  }

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get date => _date;
  int get pass => _pass;

  set pass(value) => _pass = value;

  Student.fromMap(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _date = json['date'];
    _pass = json['pass'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['description'] = this._description;
    data['date'] = this._date;
    data['pass'] = this._pass;
    return data;
  }
}