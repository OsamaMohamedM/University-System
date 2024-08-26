abstract class Person {
  int _id;
  final String name;
  String? _telephone;
  int? _age;
  String? _password;
  String _nationalId= "";

  Person(this._id, this.name, this._telephone, this._age, this._nationalId,this._password) {
  
  }

  int get id => _id;

  String? get telephone => _telephone;

  int? get age => _age;

  String? get password => _password;

  set telephone(String? telephone) {
    _telephone = telephone;
  }

  set age(int? age) {
    _age = age;
  }

  set password(String? pass) {
    if (pass != null) {
      _password = pass;
    }
  }
   void resetpass() {
    password = _nationalId;
  }
}
