import 'package:alcaldia/components/Simbolos/simbolos.dart';
import 'package:flutter/material.dart';
import 'package:alcaldia/model/dependenciaModel.dart';
import 'package:get/get.dart';

class RESTAPI {
  List<DependenciaModel> dummyFeatured = [
    DependenciaModel(
        id: 1,
        depTitulo: "Nuestros Simbolos",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        imgUrl: "assets/image/pic1.jpg",
        depEncargado: "Honshu, Japan",
      ),
    DependenciaModel(
        id: 2,
        depTitulo: "Mi Municipio",
        depDescripcion:
            " Enjoy the best experience with us!",
        imgUrl: "assets/image/pic2.jpg",
        depEncargado: "Ladakh, India",),
    DependenciaModel(
        id: 3,
        depTitulo: "Nuestra Alcaldia",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        imgUrl: "assets/image/pic3.jpg",
        depEncargado: "Honshu, Japan",),
    DependenciaModel(
        id: 4,
        depTitulo: "¿Como llegar?",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        imgUrl: "assets/image/pic4.jpg",
        depEncargado: "Honshu, Japan",)
  ];

  List<DependenciaModel> dummyAllDependencias = [
    DependenciaModel(
        depTitulo: "Regimen Subsidiado",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        imgUrl: "assets/image/pic2.jpg",
        depEncargado: "Honshu, Japan",),
    DependenciaModel(
        depTitulo: "Tesoreria",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        imgUrl: "assets/image/pic3.jpg",
        depEncargado: "Ladakh, India",),
    DependenciaModel(
        depTitulo: "Adulto Mayor",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
       
        imgUrl: "assets/image/pic1.jpg",
        depEncargado: "Honshu, Japan",
      ),
    DependenciaModel(
        depTitulo: "Oficina Juridica",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
       
        imgUrl: "assets/image/pic4.jpg",
        depEncargado: "Honshu, Japan",
     ),
    DependenciaModel(
        depTitulo: "Secretaria de Gobierno",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      
        imgUrl: "assets/image/pic2.jpg",
        depEncargado: "Honshu, Japan",
       ),
    DependenciaModel(
        depTitulo: "Servicios Sociales",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        
        imgUrl: "assets/image/pic3.jpg",
        depEncargado: "Ladakh, India",
      ),
    DependenciaModel(
        depTitulo: "Mount Fugi",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
      
        imgUrl: "assets/image/pic1.jpg",
        depEncargado: "Honshu, Japan",
     ),
    DependenciaModel(
        depTitulo: "Mountains",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
       
        imgUrl: "assets/image/pic4.jpg",
        depEncargado: "Honshu, Japan",
       ),
    DependenciaModel(
        depTitulo: "Northern Moutains",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
       
        imgUrl: "assets/image/pic2.jpg",
        depEncargado: "Honshu, Japan",
     ),
    DependenciaModel(
        depTitulo: "Himalayas Mt",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
       
        imgUrl: "assets/image/pic3.jpg",
        depEncargado: "Ladakh, India",
    ),
    DependenciaModel(
        depTitulo: "Mount Fugi",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
    
        imgUrl: "assets/image/pic1.jpg",
        depEncargado: "Honshu, Japan",),
    DependenciaModel(
        depTitulo: "Mountains",
        depDescripcion:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        imgUrl: "assets/image/pic4.jpg",
        depEncargado: "Honshu, Japan",)
  ];

  Future<List<DependenciaModel>> getFeaturedDependencias() async {
    await Future.delayed(Duration(milliseconds: 750));
    return dummyFeatured;
  }

  Future<List<DependenciaModel>> getAllDependencias() async {
    await Future.delayed(Duration(milliseconds: 950));
    return dummyAllDependencias;
  }
}
