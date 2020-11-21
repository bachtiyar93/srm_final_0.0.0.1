
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ClipPainter extends CustomClipper<Path>{
  @override

   Path getClip(Size size) {
    // path_1
    double path_1_xs = size.width / 601.42;
    double path_1_ys = size.height / 577.24;

    Path path_1 = Path()
      ..moveTo(0 * path_1_xs, 0 * path_1_ys)
      ..lineTo(601.42 * path_1_xs, 0 * path_1_ys)
      ..lineTo(601.42 * path_1_xs, 392.44 * path_1_ys)
      ..cubicTo(601.42 * path_1_xs, 392.44 * path_1_ys,591.85 * path_1_xs, 520.06 * path_1_ys,543.99 * path_1_xs, 542.4 * path_1_ys)
      ..cubicTo(496.13 * path_1_xs, 564.73 * path_1_ys,470.61 * path_1_xs, 591.85 * path_1_ys,422.75 * path_1_xs, 567.92 * path_1_ys)
      ..cubicTo(374.89 * path_1_xs, 543.99 * path_1_ys,373.3 * path_1_xs, 577.49 * path_1_ys,354.15 * path_1_xs, 483.37 * path_1_ys)
      ..cubicTo(353.98 * path_1_xs, 482.52 * path_1_ys,351.02 * path_1_xs, 379.34 * path_1_ys,370.11 * path_1_xs, 362.13 * path_1_ys)
      ..cubicTo(413.18 * path_1_xs, 287.15 * path_1_ys,439.07 * path_1_xs, 271.1 * path_1_ys,438.7 * path_1_xs, 269.6 * path_1_ys)
      ..cubicTo(469.01 * path_1_xs, 216.96 * path_1_ys,386.77 * path_1_xs, 198.04 * path_1_ys,384.46 * path_1_xs, 196.22 * path_1_ys)
      ..cubicTo(306.29 * path_1_xs, 111.67 * path_1_ys,188.24 * path_1_xs, 384.46 * path_1_ys,98.91 * path_1_xs, 346.18 * path_1_ys)
      ..cubicTo(9.57 * path_1_xs, 307.89 * path_1_ys,52.64 * path_1_xs, 189.84 * path_1_ys,52.64 * path_1_xs, 189.84 * path_1_ys)
      ..cubicTo(52.64 * path_1_xs, 189.84 * path_1_ys,65.41 * path_1_xs, 151.55 * path_1_ys,52.64 * path_1_xs, 134 * path_1_ys)
      ..cubicTo(39.88 * path_1_xs, 116.46 * path_1_ys,0 * path_1_xs, 84.55 * path_1_ys,0 * path_1_xs, 84.55 * path_1_ys)
      ..lineTo(0 * path_1_xs, 0 * path_1_ys)
      ..close();


    return path_1;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

  
}