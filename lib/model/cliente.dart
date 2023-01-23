import 'package:firebase_database/firebase_database.dart';

class Cliente {
  String _id;
  String _nombre;
  String _identificacion;
  String _area;
  String _motivo;
  String _fecha;
  int fechaPicked;
  String _hora;

  Cliente(this._id, this._nombre, this._identificacion, this._area,
      this._motivo, this._fecha, this._hora,{this.fechaPicked=0});

  Cliente.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._identificacion = obj['identificacion'];
    this._area = obj['areaa'];
    this._motivo = obj['motivo'];
    this._fecha = obj['fecha'];
    this._hora = obj['hora'];
    this.fechaPicked = obj['fechapicked'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get identificacion => _identificacion;
  String get area => _area;
  String get motivo => _motivo;
  String get fecha => _fecha;
  String get hora => _hora;

  Cliente.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _identificacion = snapshot.value['identificacion'];
    _area = snapshot.value['areaa'];
    _motivo = snapshot.value['motivo'];
    _fecha = snapshot.value['fecha'];
    _hora = snapshot.value['hora'];
    fechaPicked = snapshot.value['fechapicked'];
  }
}
