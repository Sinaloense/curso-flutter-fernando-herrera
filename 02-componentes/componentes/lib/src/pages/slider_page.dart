import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  SliderPage({Key key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 200.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Slider'),
       ),
       body: SingleChildScrollView(
         child: Column(
           children: <Widget>[
              _crearSlider(context),
              _crearCheckBox(),
              _crearSwitch(),
              _crearImagen(),
           ],
         ),
       ),
    );
  }

  Widget _crearSlider(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      // divisions: 20,
      value: _valorSlider,
      min: 10.0,
      max: screenSize.width,
      onChanged: (_bloquearCheck) ? null : (double valor) {
        setState(() {
          _valorSlider = valor;  
        });
      },
    );
  }

  Widget _crearCheckBox() {
    // return Checkbox(
    //   value: _bloquearCheck,
    //   onChanged: (bool valor) {
    //     setState(() {
    //     _bloquearCheck = valor;
    //     });
    //   }
    // );

    return CheckboxListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (bool valor) {
        setState(() {
        _bloquearCheck = valor;
        });
      }
    );
  }

  _crearSwitch() {
    return SwitchListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (bool valor) {
        setState(() {
        _bloquearCheck = valor;
        });
      }
    );
  }

  Widget _crearImagen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: 'http://pngimg.com/uploads/batman/batman_PNG111.png',
          placeholder: (context, url) => Container(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ), 
            height: 200.0
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: _valorSlider,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}