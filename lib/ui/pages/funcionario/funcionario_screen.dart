import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../model/funcionario.dart';
import 'package:image_picker/image_picker.dart';

File image;
String filename;

class FuncionarioScreen extends StatefulWidget {
  final Funcionario funcionario;

  FuncionarioScreen(this.funcionario);
  @override
  _FuncionarioScreenState createState() => _FuncionarioScreenState();
}

final FirebaseFirestore _db = FirebaseFirestore.instance;

class _FuncionarioScreenState extends State<FuncionarioScreen> {
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
      initialDate: DateTime.utc(2000, 1, 1),
      firstDate: DateTime(1600),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _fechanacimientoController.text =
            '${picked.year} - ${picked.month} - ${picked.day}';
      });
    }
  }

  List<Funcionario> items;

  TextEditingController _nombreController;
  TextEditingController _identificacionController;
  TextEditingController _cargoController;
  TextEditingController _areaController;
  TextEditingController _fechanacimientoController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _telefonoController;

  double iconSize = 20;
  String _urlImagen;
  final _formKey = GlobalKey<FormState>();

  //nuevo imagen
  String funcionarioImage;

  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

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
    _nombreController =
        new TextEditingController(text: widget.funcionario.nombre);
    _identificacionController =
        new TextEditingController(text: widget.funcionario.identificacion);
    _cargoController =
        new TextEditingController(text: widget.funcionario.cargo);
    _areaController = new TextEditingController(text: widget.funcionario.area);
    _fechanacimientoController =
        new TextEditingController(text: widget.funcionario.fechanacimiento);

    funcionarioImage = widget.funcionario.funcionarioImage;
    print(funcionarioImage);

    _emailController =
        new TextEditingController(text: widget.funcionario.email);
    _passwordController =
        new TextEditingController(text: widget.funcionario.password);

    _telefonoController =
        new TextEditingController(text: widget.funcionario.telefono);
    _urlImagen = widget.funcionario.funcionarioImage;
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
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: FlutterFlowTheme.of(context).primaryColor),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _decidirImagen()),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          pickerGallery();
                        },
                        text: 'Subir Imagen',
                        icon: Icon(
                          Icons.photo,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          textStyle: FlutterFlowTheme.of(context).bodyText1,
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          pickerCam();
                        },
                        text: 'Tomar Foto   ',
                        icon: Icon(
                          Icons.photo_camera,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          textStyle: FlutterFlowTheme.of(context).bodyText1,
                          elevation: 2,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
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
                          controller: _nombreController,
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
                          controller: _emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Ingrese el correo  electrónico...',
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
                              Icons.alternate_email,
                              size: 21,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          maxLength: 10,
                          controller: _identificacionController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Identificación',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Ingrese el número de identidad',
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
                              Icons.badge,
                              size: 22,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          maxLength: 10,
                          controller: _telefonoController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Teléfono',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Ingrese el número de Teléfono',
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
                              Icons.phone,
                              size: 18,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: FlutterFlowDropDown<String>(
                          options: ['Jefe', 'Secretario'],
                          onChanged: (value) {
                            setState(() {
                              cargoController = value;
                            });
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 0, 0, 0),
                                  ),
                          hintText: 'Seleccione el cargo...',
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
                        child: FlutterFlowDropDown<String>(
                          options: [
                            'Secretaria de hacienda',
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
                            'Familia en accion'
                          ],
                          onChanged: (value) {
                            setState(() {
                              areaController = value;
                            });
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 0, 0, 0),
                                  ),
                          hintText: 'Seleccione el área...',
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
                        child: FlutterFlowDropDown<String>(
                          options: ['funcionario', 'admin', 'user'],
                          onChanged: (value) {
                            setState(() {
                              roleController = value;
                            });
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(207, 0, 0, 0),
                                  ),
                          hintText: 'Rol y permiso...',
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
                          controller: _fechanacimientoController,
                          readOnly: true,
                          obscureText: false,
                          onTap: () {
                            _pickDateDialog();
                          },
                          decoration: InputDecoration(
                            labelText: 'Fecha de nacimiento',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintText: 'Selecione la fecha de Nacimiento...',
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
                      //nuevo imagen
                      if (_formKey.currentState.validate()) {
                        final funcionarioReference = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .doc(_emailController.text.toLowerCase());
                        _registrarFuncionario(funcionarioReference);
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

  _registrarFuncionario(DocumentReference funcionarioReference) {
    var fullPathImage;
    try {
      var fullImageName = '${_identificacionController.text}' + '.jpg';

      final Reference ref =
          FirebaseStorage.instance.ref().child('/Funcionarios/$fullImageName');
      final UploadTask task = ref.putFile(image);

      var part1 =
          'https://firebasestorage.googleapis.com/v0/b/alcaldiapp-e9da6.appspot.com/o/Funcionarios%2F${_identificacionController.text}.jpg?alt=media&token=39c258f1-feae-43fa-b89e-de16b9513ffc';

      fullPathImage = part1 + fullImageName;
    } catch (e) {
      fullPathImage =
          'https://firebasestorage.googleapis.com/v0/b/alcaldiapp-e9da6.appspot.com/o/Funcionarios%2FSinFoto%2Fuser.png?alt=media&token=c66046fc-1a49-4f0e-8136-d59d90500e4d';
    }

    if (_emailController.text.isNotEmpty) {
      funcionarioReference.set({
        'nombre': _nombreController.text,
        'identificacion': _identificacionController.text,
        'email': _emailController.text.toLowerCase(),
        'password': _passwordController.text,
        'cargo': cargoController,
        'area': areaController,
        'role': roleController,
        'telefono': _telefonoController.text,
        'fechanacimiento': _fechanacimientoController.text,
        'FuncionarioImage': '$fullPathImage'
      }).then((_) {
        image = null;
        Navigator.pop(context);
      });
    }
  }

  Widget _decidirImagen() {
    if (_urlImagen != null && _urlImagen.isNotEmpty) {
      return Image.network(
        _urlImagen,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      );
    } else {
      return image == null
          ? Image.asset(
              'assets/diseño_interfaz/user2.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            )
          : Image.file(
              image,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            );
    }
  }
}
