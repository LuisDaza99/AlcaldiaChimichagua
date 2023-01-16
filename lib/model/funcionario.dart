import 'package:firebase_database/firebase_database.dart';


class Funcionario {
  String _id;
  String _nombre;
  String _identificacion;
  String _cargo;
  String _area;
  String _fechanacimiento;
  String _funcionarioImage;

  Funcionario(this._id,this._nombre,this._identificacion,this._cargo,
      this._area,this._fechanacimiento,this._funcionarioImage);

  Funcionario.map(dynamic obj){
    this._nombre = obj['nombre'];
    this._identificacion = obj['identificacion'];
    this._cargo = obj['cargo'];
    this._area = obj['area'];
    this._fechanacimiento = obj['fechanacimiento'];
    this._funcionarioImage = obj['FuncionarioImage'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get identificacion => _identificacion;
  String get cargo => _cargo;
  String get area => _area;
  String get fechanacimiento => _fechanacimiento;
  String get funcionarioImage => _funcionarioImage;

  Funcionario.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _identificacion = snapshot.value['identificacion'];
    _cargo = snapshot.value['cargo'];
    _area = snapshot.value['area'];
    _fechanacimiento = snapshot.value['fechanacimiento'];
    _funcionarioImage = snapshot.value['FuncionarioImage'];
  }
}
