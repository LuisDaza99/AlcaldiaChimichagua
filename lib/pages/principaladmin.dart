import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:get/get.dart';

import '../utils/auth_helper.dart';

class PrincipalAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MI ALCALDIA BETA",
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Column(
    
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            child: SignInButtonBuilder(
              icon: Icons.person_add,
              backgroundColor: Colors.blueAccent,
              text: 'Registrar Funcionario',
              onPressed: () => Get.toNamed("/listafuncionarios"),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          Container(
            child: SignInButtonBuilder(
              icon: Icons.verified_user,
              backgroundColor: Colors.orange,
              text: 'Registrar Cliente',
              onPressed: () => Get.toNamed("/listaclientes"),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          TextButton(
              child: Text("Log out"),
              onPressed: () {
                AuthHelper.handleSignOut();
              },
            )
        ],
      ),
    );
  }
}
