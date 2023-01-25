
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

  Future<List<DependenciaModel>> getFeaturedDependencias([String text='']) async {
    return await api.getFeaturedDependencias(text);    
  }

  Future<List<DependenciaModel>> getAllDependencias([String text='']) async {
    return await api.getAllDependencias(text);    
  }


}