import 'package:flutter/material.dart';

class NotchedPainter extends CustomPainter {
  final int itemCount;
  final double progress;

  NotchedPainter({this.itemCount, this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = (Colors.red)
      ..style = PaintingStyle.fill;
    double canvasWidth = size.width;
    double itemWidth = canvasWidth / itemCount;
    double canvasHeight = size.height;
    double notchedWidth = itemWidth * 0.6;

    var p1 = Offset(0, 0);
    var p2 = Offset(0, canvasHeight);
    var p3 = Offset(canvasWidth, canvasHeight);
    var p4 = Offset(canvasWidth, 0);
    var p5 = Offset(progress * itemWidth + itemWidth / 2.0 + notchedWidth / 2.0 + notchedWidth * 0.2, 0);
    var p6 = Offset(progress * itemWidth + itemWidth / 2.0, canvasHeight * 0.6);
    var p7 = Offset((itemWidth - notchedWidth) / 2.0 + progress * itemWidth - notchedWidth * 0.2, 0);

    var c1 = Offset(p5.dx - notchedWidth * 0.5, 0);
    var c2 = Offset(p5.dx - notchedWidth * 0.2, p6.dy);
    var c3 = Offset(p7.dx + notchedWidth * 0.2, p6.dy);
    var c4 = Offset(p7.dx + notchedWidth * 0.5, 0);

    Path path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..lineTo(p4.dx, p4.dy)
      ..lineTo(p5.dx, p5.dy)
      ..cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, p6.dx, p6.dy)
      ..cubicTo(c3.dx, c3.dy, c4.dx, c4.dy, p7.dx, p7.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}