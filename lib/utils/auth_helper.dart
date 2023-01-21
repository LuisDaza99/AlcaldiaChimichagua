import 'dart:developer';
import 'dart:io';

import 'package:alcaldia/model/funcionario.dart';
import 'package:alcaldia/ui/pages/funcionario/funcionario_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:device_info/device_info.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signInWithEmail({String email, String password}) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = res.user;
    return user;
  }

  static signupWithEmail(
      {String email, String password, String rol = 'user'}) async {
    final res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = res.user;
    if (user != null) {
      UserHelper.saveUser(user, rol: rol);
    }
    return user;
  }

  static signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final acc = await googleSignIn.signIn();
    final auth = await acc.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    final res = await _auth.signInWithCredential(credential);
    return res.user;
  }

  static logOut() {
    GoogleSignIn().signOut();
    return _auth.signOut();
  }

  static handleSignOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static var _dbRT = FirebaseDatabase.instance.reference();

  Future<List<Funcionario>> loadUser() async {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot;

    querySnapshot = await productos.get();

    var documents = querySnapshot.docs;
    List<Funcionario> funcionarioList = [];
    documents.forEach(
      (element) {
        log('message');
        Funcionario funcionario = Funcionario.map(element);
        funcionarioList.add(funcionario);
      },
    );

    return funcionarioList;
  }

  Future<void> eliminarFuncionario(String id) async {
    CollectionReference funcionarios =
        FirebaseFirestore.instance.collection('users');

    return funcionarios
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  static searchUser(String email, String password) async {
    final correoRef = await _db
        .collection("users")
        .doc('${email.toLowerCase().trim()}')
        .get();

    var valor = Funcionario.fromMap(correoRef.data());

    Logger().i('Valor: ${valor.email}');
    if (correoRef.exists) {
      AuthHelper.signupWithEmail(
          email: email.toLowerCase().trim(), password: password, rol: valor.role);
    }
  }

  static saveUser(User user, {String rol = 'user'}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": rol,
      "build_number": buildNumber,
    };
    final userRef = _db.collection("users").doc(user.email);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
    await _saveDevice(user);
  }

  static saveUserAdmin(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "admin",
      "build_number": buildNumber,
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
    await _saveDevice(user);
  }

  static _saveDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "platform": 'android',
        "model": deviceInfo.model,
        "device": deviceInfo.device,
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "os_version": deviceInfo.systemVersion,
        "device": deviceInfo.name,
        "model": deviceInfo.utsname.machine,
        "platform": 'ios',
      };
    }
    final nowMS = DateTime.now().toUtc().millisecondsSinceEpoch;
    final deviceRef = _db
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(deviceId);
    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "updated_at": nowMS,
        "uninstalled": false,
      });
    } else {
      await deviceRef.set({
        "updated_at": nowMS,
        "uninstalled": false,
        "id": deviceId,
        "created_at": nowMS,
        "device_info": deviceData,
      });
    }
  }
}
