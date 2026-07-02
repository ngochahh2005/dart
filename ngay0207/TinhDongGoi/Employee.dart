class Employee {
  int _id;
  String _name;

  int get id => _id;
  set id(int value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;

  Employee(this._id, this._name);

  @override
  String toString() => _id.toString() + ' - ' + _name;
}


