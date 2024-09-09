import 'package:flutter/material.dart';
import '../themes/appStyles.dart';

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppStyles.curvedLineColor // Line color
      ..strokeCap = StrokeCap.round // Rounded end (l7wéf mté3 line)
      ..strokeWidth = 8.0 // Line thickness (5ochkn line)
      ..style = PaintingStyle.stroke; // Draws only the stroke

    final path = Path()
      ..moveTo(0, size.height / 2) // Start point of the curve
      ..quadraticBezierTo(
        size.width / 2, -10, // Control point (top center)
        size.width, size.height / 2, // End point
      );

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
