import 'package:alcaldia/utils/auth_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:translator/translator.dart';
import '../CustomIcons.dart';
import '../Widgets/SocialIcons.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  double fuerzaContrasenia = 0.0;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(750, 1334),
      minTextAdapt: true,
    );
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset("assets/image_02.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logoo.png",
                        width: ScreenUtil().setWidth(200),
                        height: ScreenUtil().setHeight(110),
                      ),
                      Text("Portafolio\nDe Servicios",
                          style: TextStyle(
                              fontFamily: "ITCEDSCR",
                              fontSize: ScreenUtil().setSp(32),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(180),
                  ),
                  new Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(480),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0),
                        ]),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Crear Cuenta",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            Text("Correo",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: ScreenUtil().setSp(30))),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Correo electrónico",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              controller: _emailController,

                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor, ingrese un correo';
                                }
                                if (!RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(value)) {
                                  return 'Por favor ingrese un correo válido';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30),
                            ),
                            Text("Contraseña",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: ScreenUtil().setSp(30))),
                            Stack(
                              children: [
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      hintText: "Contraseña",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 12.0)),
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return 'Por favor ingrese una contraseña';
                                    if (value.length < 6)
                                      return 'Por favor ingrese una contraseña de por lo menos 6 digítos';
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  obscureText: true,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right:5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [_contraseniaEsSegura(fuerzaContrasenia),
                                    ],
                                  ),
                                ),
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 5, 0),
                                        child: FlutterPasswordStrength(
                                          
                                          backgroundColor:
                                              Color.fromARGB(71, 158, 158, 158),
                                          height: 15,
                                          width: 130,
                                          radius: 15,
                                          password: _password,
                                          strengthCallback: (strength) {
                                             debugPrint(strength.toString());
                                              fuerzaContrasenia = strength;
                                           
                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                  hintText: "Confirmar contraseña",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              validator: (String value) {
                                if (value.isEmpty)
                                  return 'Repita la contraseña';
                                if (value != _password)
                                  return 'Las contraseñas no coinciden';
                                return null;
                              },
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil().setWidth(280),
                          height: ScreenUtil().setHeight(70),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    final user =
                                        await AuthHelper.signupWithEmail(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            context: context);
                                    if (user != null &&
                                        !(user
                                            .toString()
                                            .contains('registrado'))) {
                                      Logger().i(user);
                                      Get.snackbar('Registro Exitoso',
                                          'Ha sido registrado de manera exitosa, por favor inicie sesión a continuación');
                                      print("Usuario Creado");
                                      Navigator.pop(context);
                                    } else {
                                      Get.snackbar('Error', user.toString(),
                                          icon: Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                          colorText:
                                              Color.fromARGB(255, 114, 14, 7));
                                    }
                                  } on FirebaseException catch (e) {
                                    var errorTraducido =
                                        await traducir(e.message);
                                    Get.snackbar('Error', errorTraducido,
                                        icon: Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                        colorText:
                                            Color.fromARGB(255, 114, 14, 7));
                                    print(e);
                                  }
                                }
                              },
                              child: Center(
                                child: Text("Registrarse",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Ingresar con",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.googlePlus,
                        onPressed: () async {
                          try {
                            await AuthHelper.signInWithGoogle();
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        borderRadius: BorderRadius.circular(60),
                        onTap: () {
                          Get.toNamed("/home");
                        },
                        child: MaterialButton(
                          onPressed: () async {
                            Get.toNamed("/home");
                          },
                          color: Colors.blue,
                          child: Icon(Icons.arrow_back),
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    throw UnimplementedError();
  }

  Widget _contraseniaEsSegura(double valor) {
    if (valor > 0.0 && valor <= 0.25) {
      return Text("Insegura",
          style: TextStyle(
              color: Colors.red,
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil().setSp(10)));
    } else if (valor > 0.25 && valor <= 0.5) {
      return Text("Poco Segura",
          style: TextStyle(
              color: Color.fromARGB(255, 163, 151, 39),
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil().setSp(10)));
    } else if (valor > 0.5 && valor <= 0.75) {
      return Text("Segura",
          style: TextStyle(
              color: Colors.blue,
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil().setSp(10)));
    } else if (valor > 0.75 && valor <= 1) {
      return Text("Muy segura",
          style: TextStyle(
              color: Color.fromARGB(255, 31, 153, 35),
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil().setSp(10)));
    } else {
      return Text("",
          style: TextStyle(
              color: Colors.transparent,
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil().setSp(10)));
    }
  }

  Future<String> traducir(String input) async {
    try {
      final translator = GoogleTranslator();
      var translation = await translator.translate(input, from: 'en', to: 'es');
      return translation.toString();
    } catch (e) {
      Logger().e('Error en el traductor: ' + e.message);
      return "Ha ocurrido un error inesperado, revise su conexión a internet";
    }
  }
}
