import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: _MiPagina(),
    );
  }
}

class _MiPagina extends StatelessWidget {
  const _MiPagina({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                _ClipRRect(),
                SizedBox(height: 20),
                _ClipOval(),
                SizedBox(height: 20),
                _ClipPath(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ClipRRect extends StatelessWidget {
  const _ClipRRect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(50),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
      child: Image(
        image: NetworkImage(
          'https://1.bp.blogspot.com/-vFRhACmbKzk/YD1rhezcy9I/AAAAAAAAJ3k/AKfGALIMfNQUXjzGxDQ6cbcMFXPt2_r0QCLcBGAsYHQ/s0/image%2B1.png'
        ),
      ),
    );
  }
}

class _ClipOval extends StatelessWidget {
  const _ClipOval({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image(
        image: NetworkImage(
          'https://1.bp.blogspot.com/-vFRhACmbKzk/YD1rhezcy9I/AAAAAAAAJ3k/AKfGALIMfNQUXjzGxDQ6cbcMFXPt2_r0QCLcBGAsYHQ/s0/image%2B1.png'
        ),
      ),
    );
  }
}

class _ClipPath extends StatelessWidget {
  const _ClipPath({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _MyCustomClipper(),
      child: Image(
        image: NetworkImage(
          'https://1.bp.blogspot.com/-vFRhACmbKzk/YD1rhezcy9I/AAAAAAAAJ3k/AKfGALIMfNQUXjzGxDQ6cbcMFXPt2_r0QCLcBGAsYHQ/s0/image%2B1.png'
        ),
      ),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width * 0.5, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height);

    return path; 
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}