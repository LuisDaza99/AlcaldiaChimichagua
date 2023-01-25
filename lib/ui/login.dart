import 'package:alcaldia/ui/signup.dart';
import 'package:alcaldia/utils/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:translator/translator.dart';

import '../CustomIcons.dart';
import '../Widgets/FormCard.dart';
import '../Widgets/SocialIcons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _isSelected = false;
  final _formKey = GlobalKey<FormState>();
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

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
      body: SafeArea(
        child: Stack(
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
                    Form(
                      key: _formKey,
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(500),
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
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Iniciar Sesión",
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
                                      fontSize: ScreenUtil().setSp(26))),
                              TextFormField(
                                autocorrect: true,
                                decoration: InputDecoration(
                                    hintText: "Correo eléctronico",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                                controller: _emailController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor ingrese un correo eléctronico';
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
                                      fontSize: ScreenUtil().setSp(26))),
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
                                      return 'Mínimo 6 digítos';
                                    return null;
                                  },
                                  obscureText: true,
                                  onFieldSubmitted: (value) async {
                                    try {
                                      final user =
                                          await AuthHelper.signInWithEmail(
                                              email: _emailController.text,
                                              password: _passwordController.text);
                                      if (user != null) {
                                        print("Ingreso Exitoso");
                                        Get.toNamed('/home');
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  }),
                              SizedBox(
                                height: ScreenUtil().setHeight(35),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "¿Has olvidado tu contraseña?",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "Poppins-Medium",
                                        fontSize: ScreenUtil().setSp(28)),
                                  )
                                ],
                              )
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
                                          await AuthHelper.signInWithEmail(
                                              email: _emailController.text,
                                              password: _passwordController.text);
                                      if (user != null) {
                                        Logger().i(user);
                                        print("Ingreso Exitoso");
                                        Get.toNamed('/home');
                                      } else {}
                                    } on FirebaseException catch (e) {
                                      Logger().e(e.message);
                                      var errorTraducido =
                                          await traducir(e.message);
                                      Get.snackbar('Error', errorTraducido,
                                          icon: Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                          colorText:
                                              Color.fromARGB(255, 114, 14, 7));
                                    } catch (e) {
                                      Logger().e(e);
                                    }
                                  }
                                },
                                child: Center(
                                  child: Text("LOGIN",
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
                      children: <Widget>[
                        
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
                        Text(
                          "¿Nuevo usuario? ",
                          style: TextStyle(fontFamily: "Poppins-Medium"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignupPage(),
                                ));
                          },
                          child: Text("Registrate",
                              style: TextStyle(
                                  color: Color(0xFF5d74e3),
                                  fontFamily: "Poppins-Bold")),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
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
