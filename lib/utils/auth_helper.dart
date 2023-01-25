import 'dart:developer';
import 'dart:io';

import 'package:alcaldia/model/funcionario.dart';
import 'package:alcaldia/ui/pages/funcionario/funcionario_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:device_info/device_info.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:translator/translator.dart';

class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signInWithEmail({String email, String password}) async {
    try {
      final res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = res.user;
      Get.snackbar('Bienvenido', ' ${user.email} Su ingreso ha sido exitoso');
      print('Ingreso Exitoso');
      Future.delayed(
        Duration(seconds: 4),
        () {},
      );
      return user;
    } on FirebaseAuthException catch (e) {
      Logger().e('Error: ' + e.message + ' - Codigo: ' + e.code);
      var errorTraducido = await traducir(e.message);
      Get.snackbar('Error', errorTraducido,
          icon: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          colorText: Color.fromARGB(255, 114, 14, 7));
    } catch (e) {
      Logger().e(e);
    }
  }

  static signupWithEmail(
      {String email,
      String password,
      String rol = 'user',
      bool estaRegistrado = false,
      BuildContext context}) async {
    FirebaseFirestore _db = FirebaseFirestore.instance;

    var existe = await _db.collection("users").doc(email).get();
    if (!(existe.exists) && !estaRegistrado) {
      Map<String, dynamic> userData = {
        "FuncionarioImage": "",
        "fechanacimiento": "",
        "area": "",
        "telefono": "",
        "cargo": "",
        "password": "",
        "identificacion": "",
        "nombre": "",
        "name": "",
        "email": email.toLowerCase(),
        "last_login": "",
        "created_at": "",
        "role": rol,
        "build_number": "",
      };
      await _db.collection("users").doc(email).set(userData);
    } else {
      return 'Este usuario ya esta registrado';
    }
    final UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (res.user != null) {
      if (!estaRegistrado) {
        UserHelper.saveUser(res.user, rol: rol);
      }
    }
    Future.delayed(
      Duration(seconds: 2),
      () {},
    );

    return res.user;
  }

  static signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      final acc = await googleSignIn.signIn();
      final auth = await acc.authentication;
      Logger().v(auth.accessToken);
      final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);
      final res = await _auth.signInWithCredential(credential);

      if (res.user != null) {
        UserHelper.saveUser(res.user);
        return res.user;
      }
    } on FirebaseException catch (e) {
      Logger().e(e.message);
    } catch (e) {
      Logger().e(e);
    }
  }

  static logOut() {
    GoogleSignIn().signOut();
    return _auth.signOut();
  }

  static handleSignOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<Funcionario> getUser() async {
    List<Funcionario> listaUsuarios = [];
    //Obtener el documento
    final DocumentSnapshot userDocument = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get();

    final Map<String, dynamic> data = userDocument.data();
    return Funcionario.fromMap(data);
  }
}

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static var _dbRT = FirebaseDatabase.instance.reference();

  Future<List<Funcionario>> loadUser([String text = '']) async {
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
        if (!(funcionario.role.contains('user'))) {
          funcionarioList.add(funcionario);
        }
      },
    );

    if (text.length > 0 && funcionarioList.length > 0) {
      List<Funcionario> funcionarioListcopy = [];
      funcionarioList.forEach((element) {
        if (element.nombre
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()) ||
            element.identificacion.toString().contains(text)) {
          if (element != null) {
            Logger().v(element.id);
            funcionarioListcopy.add(element);
          }
        }
      });
      return funcionarioListcopy;
    } else {
      return funcionarioList;
    }
  }

  Future<void> eliminarFuncionario(String email) async {
    CollectionReference funcionarios =
        FirebaseFirestore.instance.collection('users');

    return funcionarios
        .doc(email)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  static searchUser(String email, String password) async {
    try {
      final correoRef = await _db
          .collection("users")
          .doc('${email.toLowerCase().trim()}')
          .get();

      var valor = Funcionario.fromMap(correoRef.data());

      Logger().i('Valor: ${valor.email}');
      if (valor != null || valor.email.isNotEmpty) {
        AuthHelper.signupWithEmail(
            email: email.toLowerCase().trim(),
            password: password,
            rol: valor.role,
            estaRegistrado: true);
      }
    } catch (e) {
      Logger().e('Error: ${e}');
    }
  }

  static saveUser(User user, {String rol = 'user'}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    Map<String, dynamic> userData = {
      "FuncionarioImage": "",
      "fechanacimiento": "",
      "area": "",
      "telefono": "",
      "cargo": "",
      "password": "",
      "identificacion": "",
      "nombre": user.displayName,
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
      await _db.collection("users").doc(user.email).set(userData);
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
        .doc(user.email)
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
