import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:serviciosconfirebase/src/models/producto_model.dart';
import 'package:serviciosconfirebase/src/preferencias/usuario_preferencias.dart';

import 'package:serviciosconfirebase/src/pages/login_page.dart';

class ProductosProvider {
  final String _url = 'https://flutter-varios-b160f.firebaseio.com';
  final _prefs = new UsuariosPreferencias();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json?auth=${ _prefs.token }';

    // Insertar datos y obtener respuesta
    final resp = await http.post(url, body: productoModelToJson(producto));

    // Mapear datos de json a dart
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json?auth=${ _prefs.token }';

    // Insertar datos y obtener respuesta
    final resp = await http.put(url, body: productoModelToJson(producto));

    // Mapear datos de json a dart
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos(BuildContext context) async {
    final url = '$_url/productos.json?auth=${ _prefs.token }';

    // Obtener datos 
    final resp = await http.get(url);

    // Mapear datos de json a dart
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    // Lista para agregar productos obtenidos
    final List<ProductoModel> productos = new List();

    if(decodedData == null) {
      return [];
    }

    // Si hay algun error, por ejemplo el token expiro
    if(decodedData['error'] != null) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);

      return [];
    }
    
    // Ciclo de productos obtenidos para agregarlos a la lista
    decodedData.forEach((String id, dynamic producto) {
      final prodTemp = ProductoModel.fromJson(producto);
      prodTemp.id = id;

      productos.add(prodTemp);
    });

    // print(productos);

    return productos;
  }

  Future<bool> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json?auth=${ _prefs.token }';

    // Borrar datos
    final resp = await http.delete(url);

    print(resp.body);

    return true;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/drezbsn9w/image/upload?upload_preset=x5yla7e9');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );

    imageUploadRequest.files.add(file);

    final streamRespose = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamRespose);

    if(resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body); // error

      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}