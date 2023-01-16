import 'package:alcaldia/components/MAPS/Google_maps.dart';
import 'package:alcaldia/main.dart';
import 'package:alcaldia/pages/cliente/listview_cliente.dart';
import 'package:alcaldia/pages/funcionario/listview_funcionario.dart';
import 'package:alcaldia/pages/principaladmin.dart';
import 'package:alcaldia/ui/home.dart';
import 'package:alcaldia/ui/login.dart';
import 'package:alcaldia/views/ViewDetails/viewDetails.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Widgets/Calendario.dart';
import '../components/MiMunicipio/Mi_municipio.dart';
import '../components/Nalcaldia/Nalcaldia.dart';
import '../components/Nalcaldia/Nalcaldia2.dart';
import '../components/Simbolos/simbolos.dart';
import '../views/HomePage/homepage.dart';

routes() => [
      GetPage(name: "/home", page: () => MainScreen()),
      GetPage(name: "/loginpage", page: () => LoginPage()),
      GetPage(name: "/listafuncionarios", page: () => ListViewFuncionario()),
      GetPage(name: "/listaclientes", page: () => ListViewCliente()),
      GetPage(name: "/principaladmin", page: () => PrincipalAdmin()),
      GetPage(name: "/view", page: () => ViewDetails()),
      GetPage(name: "/homeusuario", page: () => HomePageUsuario()),
      GetPage(name: "/homepage", page: () => HomePage()),
      GetPage(name: "/calendario", page: () => Calendario()),
      GetPage(name: "/map", page: () => GoogleMaps()),
      GetPage(name: "/simbolos", page: () => Simbolos()),
      GetPage(name: "/municipio", page: () => MiMunicipio()),
      GetPage(name: "/nalcaldia", page: () => Nalcaldia()),
      GetPage(name: "/nalcaldia2", page: () => Nalcaldia2()),
    ];
