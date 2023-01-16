import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

//nuevo para imagenes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

import 'package:alcaldia/interfazUsuario/diseño_interfaz_app_theme.dart';
import 'package:alcaldia/model/funcionario.dart';

File image;
String filename;

class FuncionarioScreen extends StatefulWidget {
  final Funcionario funcionario;

  FuncionarioScreen(this.funcionario);
  @override
  _FuncionarioScreenState createState() => _FuncionarioScreenState();
}

final funcionarioReference =
    FirebaseDatabase.instance.reference().child('funcionario');

class _FuncionarioScreenState extends State<FuncionarioScreen> {
  var _currentSelectedDate;
  DateTime picked;

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
              child: Image.asset("assets/diseño_interfaz/funcio.png"),
            ),
            Expanded(
              child: Container(),
            ),
            Image.asset("assets/image_02.png")
          ],
        ),
        SingleChildScrollView(
          //height: 570.0,

          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 130.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.blueAccent)),
                        padding: new EdgeInsets.all(5.0),
                        child: image == null
                            ? Image.asset('assets/diseño_interfaz/user2.jpg')
                            : Image.file(image),
                      ),

                      Divider(),
                      //nuevo para llamar imagen de la galeria o capturarla con la camara
                      new IconButton(
                          icon: new Icon(Icons.camera_alt),
                          onPressed: pickerCam),
                      Divider(),
                      new IconButton(
                          icon: new Icon(Icons.image),
                          onPressed: pickerGallery),
                    ],
                  ),
                  TextField(
                    controller: _nombreController,
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
                    controller: _identificacionController,
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
                  Divider(),
                  TextField(
                    controller: _areaController,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                        icon: Icon(Icons.add_task_outlined), labelText: 'Area'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Divider(),
                  TextField(
                    onTap: () {
                      _pickDateDialog();
                    },
                    controller: _fechanacimientoController,
                    readOnly: true,
                    style: TextStyle(
                        fontSize: 17.0, color: Colors.deepOrangeAccent),
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_month_outlined),
                      labelText: 'Fecha de nacimiento',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Divider(),
                  TextButton(
                      onPressed: () {
                        //nuevo imagen
                        if (widget.funcionario.id != null) {
                          var fullImageName =
                              '${_identificacionController.text}' + '.jpg';

                          final Reference ref = FirebaseStorage.instance
                              .ref()
                              .child('/Funcionarios/$fullImageName');
                          final UploadTask task = ref.putFile(image);

                          var part1 =
                              'https://firebasestorage.googleapis.com/v0/b/alcaldiapp-e9da6.appspot.com/o/Funcionarios%2Fuser2.jpg?alt=media&token=39c258f1-feae-43fa-b89e-de16b9513ffc';

                          var fullPathImage = part1 + fullImageName;

                          funcionarioReference
                              .child(widget.funcionario.id)
                              .set({
                            'nombre': _nombreController.text,
                            'identificacion': _identificacionController.text,
                            'cargo': _cargoController.text,
                            'area': _areaController.text,
                            'fechanacimiento': _fechanacimientoController.text,
                            'FuncionarioImage': '$fullPathImage'
                          }).then((_) {
                            image = null;
                            Navigator.pop(context);
                          });
                        } else {
                          //nuevo imagen

                          var fullImageName =
                              '${_identificacionController.text}' + '.jpg';

                          final Reference ref = FirebaseStorage.instance
                              .ref()
                              .child('/Funcionarios/$fullImageName');
                          final UploadTask task = ref.putFile(image);

                          var part1 =
                              'https://firebasestorage.googleapis.com/v0/b/alcaldiapp-e9da6.appspot.com/o/Funcionarios%2F${_identificacionController.text}.jpg?alt=media&token=39c258f1-feae-43fa-b89e-de16b9513ffc';

                          var fullPathImage = part1 + fullImageName;

                          funcionarioReference.push().set({
                            'nombre': _nombreController.text,
                            'identificacion': _identificacionController.text,
                            'cargo': _cargoController.text,
                            'area': _areaController.text,
                            'fechanacimiento': _fechanacimientoController.text,
                            'FuncionarioImage': '$fullPathImage' //nuevo imagen
                          }).then((_) {
                            image = null;
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 255, 255, 255),
                          elevation: 6,
                          backgroundColor: Color.fromARGB(255, 96, 169, 214)),
                      child: (widget.funcionario.id != null)
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
