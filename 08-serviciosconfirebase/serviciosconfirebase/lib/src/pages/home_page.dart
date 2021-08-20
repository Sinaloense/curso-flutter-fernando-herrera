import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:serviciosconfirebase/src/bloc/provider.dart';

import 'package:serviciosconfirebase/src/models/producto_model.dart';
import 'package:serviciosconfirebase/src/pages/producto_page.dart';
import 'package:serviciosconfirebase/src/preferencias/usuario_preferencias.dart';
import 'package:serviciosconfirebase/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final prefs = new UsuariosPreferencias();
    prefs.ultimaPagina = HomePage.routeName;

    // final bloc = Provider.of(context);
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Home Page'),
      ),
      drawer: MenuWidget(),
      body: _crearListado(context, productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(BuildContext context, ProductosBloc productosBloc) {
    final size = MediaQuery.of(context).size;

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        double imgHeight = size.height * 0.40;
        double imgWidth = size.width * 0.80;
        double gridAspectRatio = size.width / (size.height * 1.2);

        if(orientation == Orientation.landscape) {
          imgHeight = size.height * 0.40;
          imgWidth = size.width * 0.40;
          // gridAspectRatio = size.width / (size.height * 2.1);
          gridAspectRatio = (size.height * 1.1) / size.width;
        }

        return StreamBuilder(
          stream: productosBloc.productosStream,
          builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
            if(snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                  childAspectRatio: gridAspectRatio,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) => _crearItem(context, productosBloc, snapshot.data[i], imgHeight, imgWidth),
              );

              // return ListView.builder(
              //   padding: EdgeInsets.only(bottom: size.height * 0.15),
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (BuildContext context, int i) => _crearItem(context, productosBloc, snapshot.data[i], imgHeight, imgWidth),
              // );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      }
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc, ProductoModel producto, double imgHeight, double imgWidth) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red
      ),
      onDismissed: (DismissDirection dirreccion) {
        productosBloc.borrarProducto(context, producto.id);
      },
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, ProductoPage.routeName, arguments: producto),
        child: Card(
          child: Column(
            children: <Widget>[
              Text(producto.titulo, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              SizedBox(height: 10.0),
              (producto.fotoUrl == null)
                ? Image(
                  image: AssetImage('assets/img/no-image.png'),
                  height: imgHeight,
                  width: imgWidth,
                  fit: BoxFit.cover,
                )
                : CachedNetworkImage(
                  imageUrl: producto.fotoUrl,
                  placeholder: (context, url) => Image.asset('assets/img/jar-loading.gif'),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: imgHeight,
                  width: imgWidth,
                  fit: BoxFit.cover,
                ),
                // FadeInImage(
                //   placeholder: AssetImage('assets/img/jar-loading.gif'),
                //   image: NetworkImage(producto.fotoUrl),
                //   height: imgHeight,
                //   width: imgWidth,
                //   fit: BoxFit.cover,
                // ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star, color: Colors.orange),
                      Icon(Icons.star),
                    ],
                  ),
                  subtitle: Text(producto.valor.toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed(context, ProductoPage.routeName),
    );
  }
}