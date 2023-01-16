import 'package:alcaldia/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../CustomIcons.dart';
import '../Widgets/SocialIcons.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController;
  TextEditingController _rolController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _rolController = TextEditingController(text: "");
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
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                          fontSize: ScreenUtil().setSp(26))),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                    controller: _emailController,
                    validator: (String value) {
                      if (value.isEmpty)
                        return 'Por favor, introduzca un texto';
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
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                    validator: (String value) {
                      if (value.isEmpty)
                        return 'Por favor ingrese algún texto o números';
                      return null;
                    },
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                        hintText: "Confirm password",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                    validator: (String value) {
                      if (value.isEmpty)
                        return 'Por favor ingrese algún texto o números';
                      return null;
                    },
                    obscureText: true,
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
                                      if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  if (_confirmPasswordController.text.isEmpty ||
                      _passwordController.text !=
                          _confirmPasswordController.text) {
                    print("confirm password does not match");
                    return;
                  }
                  try {
                    final user = await AuthHelper.signupWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (user != null) {
                      print("Usuario Creado");
                      Get.toNamed("/loginpage");
                    }
                  } catch (e) {
                    print(e);
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
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {},
                      ),
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
                      SocialIcon(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF00c6fb),
                          Color(0xFF005bea),
                        ],
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.toNamed("/home");
                        },
                        child: MaterialButton(
                          onPressed: () async {
                            Get.toNamed("/home");
                          },
                          color: Colors.blue,
                          child: Icon(Icons.logout),
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
}
