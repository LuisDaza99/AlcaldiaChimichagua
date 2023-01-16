import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


class FormCard extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  @override
  Widget build(BuildContext context) {
    return new Container(
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
            Text("Iniciar Session",
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
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
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
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                        validator: (String value) {
                          if (value.isEmpty)
                            return 'Por favor ingrese algún texto o números';
                          return null;
                        },
                        obscureText: true,
                      ),
                   
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
      
       
       
    );
    
  }
  
  
  
}
