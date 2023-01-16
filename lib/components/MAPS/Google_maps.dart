import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../interfazUsuario/diseño_interfaz_app_theme.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(9.250769, -73.8125395),
    zoom: 15,
  );

  static final CameraPosition _Alcaldia =
      CameraPosition(target: LatLng(9.252648, -73.811364), zoom: 19);

  static final Marker _initialCameraMarker = Marker(
    markerId: MarkerId('_initialCameraPosition'),
    infoWindow: InfoWindow(title: 'Alcaldia Municipal'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(9.252648, -73.811364),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: {_initialCameraMarker},
        initialCameraPosition: _initialCameraPosition,
        mapType: MapType.hybrid,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToAlcaldia,
        label: Text('Ir a la Alcaldia'),
        icon: Icon(Icons.directions_walk_outlined),
      ),
    );
  }

  Future<void> _goToAlcaldia() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_Alcaldia));
  }
}
