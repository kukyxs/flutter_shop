import 'package:flutter/material.dart';
import 'package:amap_base/amap_base.dart';
import 'package:flutter_shop/provides/home_provide.dart';
import 'package:provide/provide.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  AMapController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provide = Provide.value<HomeProvide>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          _controller = controller;
          _controller.showIndoorMap(true);
          _controller.setZoomLevel(19);
        },
        amapOptions: AMapOptions(
          compassEnabled: false,
          zoomControlsEnabled: true,
          logoPosition: LOGO_POSITION_BOTTOM_LEFT,
          camera: CameraPosition(target: LatLng(provide.latitude, provide.longitude)/*, zoom: 15.0*/),
        ),
      ),
    );
  }
}
