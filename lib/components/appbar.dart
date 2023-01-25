import 'package:alcaldia/flutter_flow/flutter_flow_theme.dart';
import 'package:alcaldia/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:alcaldia/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/funcionario.dart';

AppBar HomeAppBar = AppBar(
  backgroundColor: Color.fromARGB(255, 25, 116, 28),
  title: Center(
      child: Text(
    "ALCALDIA",
    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
  )),
  actions: [
    IconButton(
        icon: Icon(
          Icons.account_circle,
          size: 36,
        ),
        onPressed: () async {
          Funcionario funcionario = await AuthHelper().getUser();
          switch (funcionario.role) {
            case 'user':
              Get.toNamed("/homepage");
              break;
            case 'admin':
              Get.toNamed("/principaladmin");
              
              break;
            case 'funcionario':
             Get.toNamed("/principaladmin");
              break;
            default:
              Get.toNamed("/homepage");
          }
        })
  ],
);
