import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:alcaldia/model/funcionario.dart';


class FuncionarioInformation extends StatefulWidget {
  final Funcionario funcionario;
  FuncionarioInformation(this.funcionario);
  @override
  _FuncionarioInformationState createState() => _FuncionarioInformationState();
}

final funcionarioReference = FirebaseDatabase.instance.reference().child('funcionario');

class _FuncionarioInformationState extends State<FuncionarioInformation> {

  List<Funcionario> items;

  String funcionarioImage;//nuevo

  @override
  void initState() {   
    super.initState();
    funcionarioImage = widget.funcionario.funcionarioImage;//nuevo
    print(funcionarioImage);//nuevo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion del funcionario'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[                
                new Text("Nombre : ${widget.funcionario.nombre}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Identificacion : ${widget.funcionario.identificacion}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Cargo : ${widget.funcionario.cargo}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Area : ${widget.funcionario.area}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Fecha De Nacimiento : ${widget.funcionario.fechanacimiento}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                Container(
                          height: 300.0,
                          width: 300.0,
              child: Center(
                child: funcionarioImage == ''
                    ? Text('No Image')
                    : Image.network(funcionarioImage+'?alt=media'),//nuevo para traer la imagen de firestore
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
