import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_geolocation_geolocation_dto.dart';

import '../../utils/main_colors.dart';

class MapPage extends StatefulWidget {
  ChatGeolocationDto location;

  MapPage({Key? key, required this.location}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    CameraPosition startPosition = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 14.4746,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.mainGreen,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: startPosition,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
        },
      ),
    );
  }
}
