import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
//nuevo para imagenes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:alcaldia/interfazUsuario/diseño_interfaz_app_theme.dart';
import 'package:alcaldia/model/cliente.dart';

String filename;

class ClienteScreen extends StatefulWidget {
  final Cliente cliente;
  ClienteScreen(this.cliente);
  @override
  _ClienteScreenState createState() => _ClienteScreenState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ClienteScreenState extends State<ClienteScreen> {
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  var _currentSelectedDate;
  DateTime picked;

  void _pickDateDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime.now().add(Duration(days: -(365 * 150))),
    );

    if (picked != null) {
      setState(() {
        _fechaController.text =
            '${picked.year} - ${picked.month} - ${picked.day}';
      });
    }
  }

  void _showPicker() async {
    Navigator.of(context).push(showPicker(
      value: _time,
      onChange: (TimeOfDay time) {
        setState(() {
          _time = time;
        });

        _horaController.text = '${_time.hour} - ${_time.minute}';

        print(_time);
      },
      onChangeDateTime: (DateTime dateTime) {},
      is24HrFormat: false,
      iosStylePicker: true,
      disableHour: false,
    ));
  }

  List<Cliente> items;

  TextEditingController _nombreeController;
  TextEditingController _identificacionnController;
  TextEditingController _areaaController;
  TextEditingController _motivoController;
  TextEditingController _fechaController;
  TextEditingController _horaController;

  //nuevo imagen

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }
  //fin nuevo imagen

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreeController = new TextEditingController(text: widget.cliente.nombre);
    _identificacionnController =
        new TextEditingController(text: widget.cliente.identificacion);
    _areaaController = new TextEditingController(text: widget.cliente.areaa);
    _motivoController = new TextEditingController(text: widget.cliente.motivo);
    _fechaController = new TextEditingController(text: widget.cliente.fecha);
    _horaController = new TextEditingController(text: widget.cliente.hora);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 1.0, right: 60.0, bottom: 80.0),
              child: Image.asset("assets/diseño_interfaz/funcionarios03.png"),
            ),
            Expanded(
              child: Container(),
            ),
            Image.asset("assets/image_02.png")
          ],
        ),
        SingleChildScrollView(
          //height: 570.0,

          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 150.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Center(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nombreeController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), labelText: 'Nombre'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _identificacionnController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment),
                        labelText: 'Identificacion'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _areaaController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment_ind_outlined),
                        labelText: 'Area encargada'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Divider(),
                  TextField(
                    controller: _motivoController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.add_task_outlined),
                        labelText: 'Motivo'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Divider(),
                  TextField(
                    onTap: () {
                      _pickDateDialog();
                    },
                    controller: _fechaController,
                    readOnly: true,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_month_outlined),
                      labelText: 'Fecha',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Divider(),
                  TextField(
                    onTap: () {
                      _showPicker();
                    },
                    controller: _horaController,
                    readOnly: true,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                      icon: Icon(Icons.timelapse),
                      labelText: 'Hora',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Divider(),
                  TextButton(
                      onPressed: () {
                        //nuevo imagen
                        if (widget.cliente.id != null) {
                          clienteReference.child(widget.cliente.id).set({
                            'nombre': _nombreeController.text,
                            'identificacion': _identificacionnController.text,
                            'area encargada': _areaaController.text,
                            'motivo': _motivoController.text,
                            'fecha': _fechaController.text,
                            'fechapicked': picked.millisecondsSinceEpoch,
                            'hora': _horaController.text,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        } else {
                          //nuevo imagen

                          clienteReference.push().set({
                            'nombre': _nombreeController.text,
                            'identificacion': _identificacionnController.text,
                            'area encargada': _areaaController.text,
                            'motivo': _motivoController.text,
                            'fecha': _fechaController.text,
                            'fechapicked': picked.millisecondsSinceEpoch,
                            'hora': _horaController.text,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          elevation: 6,
                          backgroundColor: Color.fromARGB(255, 96, 169, 214)),
                      child: (widget.cliente.id != null)
                          ? Text('Update')
                          : Text(
                              'Agregar',
                            )),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 1.0, right: 360.0, bottom: 720.0),
          child: SizedBox(
            width: AppBar().preferredSize.height,
            height: AppBar().preferredSize.height,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: InterfazAppTheme.nearlyBlack,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
