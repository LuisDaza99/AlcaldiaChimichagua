import 'dart:developer';
import 'dart:io';

import 'package:alcaldia/ui/pages/FuncionarioPageAdmin.dart';
import 'package:alcaldia/ui/pages/funcionario/listview_funcionario.dart';
import 'package:alcaldia/ui/pages/principaladmin.dart';
import 'package:alcaldia/routes/my_routes.dart';
import 'package:alcaldia/ui/views/HomePage/homepage.dart';
import 'package:alcaldia/ui/views/HomePage/state/homepageStateProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alcaldia/ui/admin_home.dart';
import 'package:alcaldia/ui/home.dart';
import 'package:alcaldia/ui/login.dart';
import 'package:alcaldia/utils/auth_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

void main() async {
  Locale _local = Locale('es', 'CO');
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      _local,
    ],
    locale: _local,
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    navigatorKey: Get.key,
    getPages: routes(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext csontext) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'CO'),
      ],
      locale: const Locale('es', 'CO'),
      title: 'Alcaldia de todos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageStateProvider())
      ],
      child: StreamBuilder<User>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              log(snapshot.data.email);
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(snapshot.data.email)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final userDoc = snapshot.data;
                    final user = userDoc.data();

                    switch (user['role']) {
                      case 'admin':
                        return HomePageUsuario();
                        break;
                      case 'user':
                        return HomePageUsuario();
                        break;
                      case 'funcionario':
                        return HomePageUsuario();
                        break;
                      default:
                        return HomePageUsuario();
                    }
                  } else {
                    return Material(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            }
            return LoginPage();
          }),
    );
  }
}
