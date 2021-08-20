import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:serviciosconfirebase/src/bloc/productos_bloc.dart';
import 'package:serviciosconfirebase/src/bloc/provider.dart';

import 'package:serviciosconfirebase/src/models/producto_model.dart';
import 'package:serviciosconfirebase/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  static final routeName = 'productoPage';

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;

    // Si hay un producto en argumentos
    if(prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () => _procesarImagen(ImageSource.gallery),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => _procesarImagen(ImageSource.camera),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          double imgHeight = size.height * 0.40;
          double imgWidth = size.width * 0.80;

          if(orientation == Orientation.landscape) {
            imgHeight = size.height * 0.60;
            imgWidth = size.width * 0.60;
          }

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    _mostrarFoto(context, imgHeight, imgWidth),
                    _crearNombre(),
                    _crearPrecio(),
                    _crearDisponible(context),
                    _crearBoton(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (String value) {
        if(value.length < 3) {
          return 'Ingrese el nombre del producto';
        }
        else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (String value) {
        if(utils.isNumeric(value) == false) {
          return 'Sólo números';
        }
        else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible(BuildContext context) {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Theme.of(context).primaryColor,
      onChanged: (bool value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton(context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : () => _submit(context),
    );
  }

  void _submit(BuildContext context) async {
    if(formKey.currentState.validate() == false) {
      return;
    }

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto != null) {
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }

    if(producto.id == null) {
      productosBloc.agregarProducto(producto);
      mostrarSnackbar('Registro creado');
    }
    else {
      productosBloc.editarProducto(producto);
      mostrarSnackbar('Registro editado');
    }

    await Future.delayed(Duration(milliseconds: 2000));

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto(BuildContext context, double imgHeight, double imgWidth) {
    if(producto.fotoUrl != null) {
      return CachedNetworkImage(
        imageUrl: producto.fotoUrl,
        placeholder: (context, url) => Image.asset('assets/img/jar-loading.gif'),
        errorWidget: (context, url, error) => Icon(Icons.error),
        height: imgHeight,
        width: imgWidth,
        fit: BoxFit.cover,
      );

      // return FadeInImage(
      //   placeholder: AssetImage('assets/img/jar-loading.gif'),
      //   image: NetworkImage(producto.fotoUrl),
      //   height: imgHeight,
      //   width: imgWidth,
      //   fit: BoxFit.cover,
      // );
    }
    else {
      if(foto != null) {
        return Image.file(
          foto,
          height: imgHeight,
          width: imgWidth,
          fit: BoxFit.cover,
        );
      }
      
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        height: imgHeight,
        width: imgWidth,
        fit: BoxFit.cover,
      );
    }
  }

  _procesarImagen(ImageSource origen) async {
    File tmpNuevaFoto = await ImagePicker.pickImage(
      source: origen,
      maxWidth: 1024.0,
      maxHeight: 768.0,
    );

    setState(() {
      if(tmpNuevaFoto != null) {
        producto.fotoUrl = null;
        foto = tmpNuevaFoto;
      }
    });
  }
}