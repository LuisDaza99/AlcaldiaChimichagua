
import 'package:flutter/material.dart';
import 'package:alcaldia/model/dependenciaModel.dart';
import 'package:alcaldia/utils/restAPI.dart';

class HomePageStateProvider extends ChangeNotifier
{

  bool showBottomDrawer = true;
  RESTAPI api = RESTAPI();

  void setShowBottomDrawer(bool value){
    this.showBottomDrawer = value;
    print("\n Bottom Scroll State : "+this.showBottomDrawer.toString());
    notifyListeners();
  }

  List<String> kTopListLink = [
    'Portafolio de servicios'
  ];

  Future<List<DependenciaModel>> getFeaturedDependencias() async {
    return await api.getFeaturedDependencias();    
  }

  Future<List<DependenciaModel>> getAllDependencias() async {
    return await api.getAllDependencias();    
  }

  Future<void> GetTopList() async {

      await Future.delayed(const Duration(milliseconds: 500), (){});

      kTopListLink.add("India");

      notifyListeners();
      
  }

}