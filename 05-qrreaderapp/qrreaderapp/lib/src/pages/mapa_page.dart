import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController mapCtrl = new MapController();

  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapCtrl.move(scan.getLatLng(), 15.0);
            }
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: mapCtrl,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  LayerOptions _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoibWFudWVsbXR6MTMyMSIsImEiOiJjazZqbTJjNzcwMzIwM2RsYTcxeDJ2djJ4In0.bkm9e-irGD0V_8M0FVV2Nw',
        'id'          : 'mapbox.$tipoMapa', // streets, dark, light, outdoors, satellite
      }
    );
  }

  LayerOptions _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (BuildContext context) => Container(
            // color: Colors.red,
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.repeat
      ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        if(tipoMapa == 'streets') {}

        switch (tipoMapa) {
          case 'streets':
            tipoMapa = 'dark';
            break;
          case 'dark':
            tipoMapa = 'light';
            break;
          case 'light':
            tipoMapa = 'outdoors';
            break;
          case 'outdoors':
            tipoMapa = 'satellite';
            break;
          default:
            tipoMapa = 'streets';
        }

        setState((){});
      }
    );
  }
}