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
      body: Center(
        child: Container(
          width: 260.0,
          height: 260.0,
          // color: Colors.black12,
          child: CustomPaint(
            painter: _MyPainterPersonalizado(),
          ),
        ),
      ),
    );
  }
}

class _MyPainterPersonalizado extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Color(0xff21232a)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    final path = new Path()
      // Primer palo vertical
      ..moveTo(size.width * 0.3333, 0)
      ..lineTo(size.width * 0.3333, size.height)

      // Segundo palo vertical
      ..moveTo(size.width * 0.6666, 0)
      ..lineTo(size.width * 0.6666, size.height)

      // Primer palo horizontal
      ..moveTo(0, size.height * 0.3333)
      ..lineTo(size.width, size.height * 0.3333)

      // Segundo palo horizontal
      ..moveTo(0, size.height * 0.6666)
      ..lineTo(size.width, size.height * 0.6666);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MyPainterPersonalizado oldDelegate) => false;

  // @override
  // bool shouldRebuildSemantics(_MyPainterPersonalizado oldDelegate) => false;
}