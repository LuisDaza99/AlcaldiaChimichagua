import 'package:flutter/material.dart';
import 'package:alcaldia/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

AppBar HomeAppBar = AppBar(
  title: Center(
      child: Text(
    "ALCALDIA",
    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
  )),
  leading: PopupMenuButton(
     offset: Offset.fromDirection(2, 58),
    onSelected: (value){

    },
    icon: Icon(Icons.menu),
    itemBuilder: (context) {
      return kAppBarMenuOptions
          .map(
            (option) => PopupMenuItem(
              value: option,
              child: Container(
                width: 120,
                child: Text(option,style: TextStyle(color: Colors.black),),
              ),
            ),
          )
          .toList();
    },
  ),
  actions: [
    IconButton(
        icon: Icon(
          Icons.account_circle,
          size: 36,
        ),
        onPressed: () 
          => Get.toNamed("/homepage"),
        )
  ],
);

