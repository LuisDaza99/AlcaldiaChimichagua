import 'package:alcaldia/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Home page"),
            TextButton(
              child: Text("Log out"),
              onPressed: () {
                AuthHelper.logOut();
                Get.toNamed("/loginpage");
              },
            )
          ],
        ),
      ),
    );
  }
}
