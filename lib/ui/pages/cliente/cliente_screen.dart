import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../model/cliente.dart';
import '../../../model/funcionario.dart';
import 'package:image_picker/image_picker.dart';

File image;
String filename;

class ClienteScreen extends StatefulWidget {
  final Cliente cliente;

  ClienteScreen(this.cliente);
  @override
  _ClienteScreenState createState() => _ClienteScreenState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');
final FirebaseFirestore _db = FirebaseFirestore.instance;

class _ClienteScreenState extends State<ClienteScreen> {
  String areaEncargadaController;
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  DateTime picked;
  String cargoController;
  String areaController;
  String roleController;
  String telefonoController;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
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
  TextEditingController _areaEncargadaController;
  TextEditingController _motivoController;
  TextEditingController _fechaController;
  TextEditingController _horaController;
  final _formKey = GlobalKey<FormState>();

  double iconSize = 20;
 

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _nombreeController = new TextEditingController(text: widget.cliente.nombre);
    _identificacionnController =
        new TextEditingController(text: widget.cliente.identificacion);
    _areaEncargadaController = new TextEditingController(text: widget.cliente.area);
    _motivoController = new TextEditingController(text: widget.cliente.motivo);
    _fechaController = new TextEditingController(text: widget.cliente.fecha);
    _horaController = new TextEditingController(text: widget.cliente.hora);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).gray600,
            size: 32,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: FlutterFlowTheme.of(context).gray200),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset("assets/diseño_interfaz/user2.jpg"),),
                 
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (true)
                              ? (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'No deje este campo vacio';
                                  }
                                  return null;
                                }
                              : null,
                              maxLength: 25,
                          controller: _nombreeController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Ingresa el nombre....',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (true)
                              ? (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'No deje este campo vacio';
                                  }
                                  return null;
                                }
                              : null,
                              maxLength: 10,
                          controller: _identificacionnController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Identificación',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Ingrese la identificación...',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 21,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                   
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: FlutterFlowDropDown<String>(
                          options: ['Secretaria de hacienda',
                            'Regimen subsidiado',
                            'Secretariia de planeacion',
                            'Comisaria de familia',
                            'Adulto mayor',
                            'Desarrollo comunitario',
                            'Oficina juridica',
                            'Recaudo y Tesoreria',
                            'Sisben',
                            'Secretaria de servicios sociales',
                            'Secretaria de gobierno',
                            'Familia en accion'],
                          onChanged: (value) {
                            setState(() {
                              areaEncargadaController = value;
                            });
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 0, 0, 0),
                                  ),
                          hintText: 'Seleccione el area encargada...',
                          fillColor: Color(0xFFF1F4F8),
                          elevation: 2,
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          borderRadius: 8,
                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                         Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (true)
                              ? (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'No deje este campo vacio';
                                  }
                                  return null;
                                }
                              : null,
                          
                          controller: _motivoController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Motivo',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Ingrese el motivo del servicio...',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            prefixIcon: Icon(
                              Icons.add_task,
                              size: 23,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (true)
                              ? (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'No deje este campo vacio';
                                  }
                                  return null;
                                }
                              : null,
                          controller: _fechaController,
                          readOnly: true,
                          obscureText: false,
                          onTap: () {
                            _pickDateDialog();
                          },
                          decoration: InputDecoration(
                            labelText: 'Fecha',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Selecione la fecha ...',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                                contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              size: 23,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          validator: (true)
                              ? (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'No deje este campo vacio';
                                  }
                                  return null;
                                }
                              : null,
                          controller: _horaController,
                          readOnly: true,
                          obscureText: false,
                          onTap: () {
                            _showPicker();
                          },
                          decoration: InputDecoration(
                            labelText: 'Hora',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Selecione la hora ...',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                                contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
                            prefixIcon: Icon(
                              Icons.access_alarm,
                              size: 23,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                       if (widget.cliente.id != null) {
                          clienteReference.child(widget.cliente.id).set({
                            'nombre': _nombreeController.text,
                            'identificacion': _identificacionnController.text,
                            'area encargada': areaEncargadaController,
                            'motivo': _motivoController.text,
                            'fecha': _fechaController.text,
                            'fechapicked': picked.millisecondsSinceEpoch,
                            'hora': _horaController.text,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        } else {

                          clienteReference.push().set({
                            'nombre': _nombreeController.text,
                            'identificacion': _identificacionnController.text,
                            'area encargada': areaEncargadaController,
                            'motivo': _motivoController.text,
                            'fecha': _fechaController.text,
                            'fechapicked': picked.millisecondsSinceEpoch,
                            'hora': _horaController.text,
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        }
                    },
                    text: 'AGREGAR',
                    icon: Icon(
                      Icons.person_add,
                      size: 22,
                    ),
                    options: FFButtonOptions(
                      width: 160,
                      height: 45,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryBtnText),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
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
