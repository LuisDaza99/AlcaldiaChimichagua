import 'package:firebase_database/firebase_database.dart';

class Funcionario {
  String _id;
  String _nombre;
  String _identificacion;
  String _email;
  String _password;
  String _telefono;
  String _cargo;
  String _area;
  String _role;
  String _fechanacimiento;
  String _funcionarioImage;

  Funcionario(
      this._id,
      this._nombre,
      this._identificacion,
      this._email,
      this._password,
      this._telefono,
      this._cargo,
      this._area,
      this._role,
      this._fechanacimiento,
      this._funcionarioImage);

  Funcionario.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._identificacion = obj['identificacion'];
    this._email = obj['email'];
    this._password = obj['password'];
    this._telefono = obj['telefono'];
    this._cargo = obj['cargo'];
    this._area = obj['area'];
    this._role = obj['role'];
    this._fechanacimiento = obj['fechanacimiento'];
    this._funcionarioImage = obj['FuncionarioImage'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get identificacion => _identificacion;
  String get email => _email;
  String get password => _password;
  String get telefono => _telefono;
  String get cargo => _cargo;
  String get area => _area;
  String get role => _role;
  String get fechanacimiento => _fechanacimiento;
  String get funcionarioImage => _funcionarioImage;

  Funcionario.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _identificacion = snapshot.value['identificacion'];
    _email = snapshot.value['email'];
    _password = snapshot.value['password'];
    _telefono = snapshot.value['telefono'];
    _cargo = snapshot.value['cargo'];
    _area = snapshot.value['area'];
    _role = snapshot.value['role'];
    _fechanacimiento = snapshot.value['fechanacimiento'];
    _funcionarioImage = snapshot.value['FuncionarioImage'];
  }
}
