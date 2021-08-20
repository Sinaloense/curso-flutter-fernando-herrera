import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:serviciosconfirebase/src/models/producto_model.dart';
import 'package:serviciosconfirebase/src/providers/productos_providers.dart';

class ProductosBloc {
  // BehaviorSubject son los Streams de rxdart
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _productosProvider = new ProductosProvider();

  dispose() {
    _productosController.close();
    _cargandoController.close();
  }

  // Recuperar los datos del Stream
  Stream<List<ProductoModel>> get productosStream => _productosController.stream;
  Stream<bool> get cargandoStream => _cargandoController.stream;

  void cargarProductos(BuildContext context) async {
    final productos = await _productosProvider.cargarProductos(context);
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  void editarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto(BuildContext context, String id) async {
    await _productosProvider.borrarProducto(id);
    cargarProductos(context);
  }

  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;
  }
}