import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:alcaldia/utils/auth_helper.dart';

import 'package:alcaldia/model/funcionario.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'funcionario_information.dart';
import 'funcionario_screen.dart';

class ListViewFuncionario extends StatefulWidget {
  @override
  _ListViewFuncionarioState createState() => _ListViewFuncionarioState();
}

final funcionarioReference =
    FirebaseDatabase.instance.reference().child('funcionario');

class _ListViewFuncionarioState extends State<ListViewFuncionario> {
  StreamSubscription<Event> _onFuncionarioAddedSubscription;
  StreamSubscription<Event> _onFuncionarioChangedSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 175, 203, 216),
        appBar: AppBar(
          title: Text('Todos los funcionarios'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 38, 148, 192),
        ),
        body: Center(
          child: FutureBuilder<List<Funcionario>>(
            future: UserHelper().loadUser(),
            builder: (BuildContext context, items) {
              if (items.connectionState == ConnectionState.done &&
                  items.hasData) {
                return ListView.builder(
                    itemCount: items.data.length,
                    padding: EdgeInsets.only(top: 3.0),
                    itemBuilder: (context, position) {
                      return Column(
                        children: <Widget>[
                          Divider(
                            height: 1.0,
                          ),
                          Container(
                            padding: new EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 5,
                              child: Row(
                                children: <Widget>[
                                  //nuevo imagen
                                  new Container(
                                    padding: new EdgeInsets.all(5.0),
                                    child:
                                        '${items.data[position].funcionarioImage}' ==
                                                ''
                                            ? Text('No image')
                                            : Image.network(
                                                '${items.data[position].funcionarioImage}' +
                                                    '?alt=media',
                                                fit: BoxFit.fill,
                                                height: 57.0,
                                                width: 57.0,
                                              ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                        title: Text(
                                          '${items.data[position].nombre}',
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 21.0,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${items.data[position].cargo}',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 56, 52, 52),
                                            fontSize: 21.0,
                                          ),
                                        ),
                                        onTap: () =>
                                            _navigateToFuncionarioInformation(
                                                context, items.data[position])),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _showDialog(
                                        items.data, context, position),
                                  ),

                                  //onPressed: () => _deleteFuncionarios(context, items[position],position)),
                                  IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () => _navigateToFuncionario(
                                          context, items.data[position])),
                                ],
                              ),
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            child: Text("Regresar"),
                            onPressed: () {
                              Get.toNamed("/home");
                            },
                          )
                        ],
                      );
                    });
              } else {
                return Container();
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 38, 148, 192),
          onPressed: () async{
            await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FuncionarioScreen(
              Funcionario(null, '', '', '', '', '', '', '', '', '', ''))),
    ).then((value) {setState(() {
      
    });});
          },
        ),
      ),
    );
  }

  //nuevo para que pregunte antes de eliminar un registro
  void _showDialog(items, context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content:
              Text('Esta seguro de que quieres eliminar este funcionario?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.purple,
              ),
              onPressed: () async {  
                await UserHelper().eliminarFuncionario(items.data[position]._email);
                setState(() {
                  
                });
              },
            ),
            new TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteFuncionario(items, BuildContext context, Funcionario funcionario,
      int position) async {
    await funcionarioReference.child(funcionario.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToFuncionarioInformation(
      BuildContext context, Funcionario funcionario) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FuncionarioScreen(funcionario)),
    );
  }

  void _navigateToFuncionario(
      BuildContext context, Funcionario funcionario) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FuncionarioInformation(funcionario)),
    );
  }

  void _createNewFuncionario(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FuncionarioScreen(
              Funcionario(null, '', '', '', '', '', '', '', '', '', ''))),
    );
  }
}
