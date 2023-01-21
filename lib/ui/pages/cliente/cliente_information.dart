import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:alcaldia/model/cliente.dart';


class ClienteInformation extends StatefulWidget {
  final Cliente cliente;
  ClienteInformation(this.cliente);
  @override
  _ClienteInformationState createState() => _ClienteInformationState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ClienteInformationState extends State<ClienteInformation> {

  List<Cliente> items;



  @override
  void initState() {   
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion del cliente'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[                
                new Text("Nombre : ${widget.cliente.nombre}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Identificacion : ${widget.cliente.identificacion}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Area encargada : ${widget.cliente.areaa}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Area : ${widget.cliente.motivo}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Fecha: ${widget.cliente.fecha}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Hora: ${widget.cliente.hora}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                Container(
                          height: 300.0,
                          width: 300.0,
              child: Center(
                child: 
                    Image.asset('assets/diseño_interfaz/user2.jpg'), //nuevo para traer la imagen de firestore
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
