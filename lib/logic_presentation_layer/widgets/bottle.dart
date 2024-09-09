import 'package:flutter/material.dart';
import '../themes/appStyles.dart';


class BottlePainter extends CustomPainter {

  final double waterLevel;

  BottlePainter({required this.waterLevel});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppStyles.bottleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Draw the neck of the bottle with rounded corners (small rectangle at the center top)
    double neckWidth = size.width * 0.3;
    double neckHeight = size.height * 0.12; // height of bottle head
    double neckLeft = (size.width - neckWidth) / 2;
    Rect neckRect = Rect.fromLTWH(neckLeft, 0, neckWidth, neckHeight );
    RRect roundedNeckRect = RRect.fromRectAndCorners(
      neckRect,
      topLeft: Radius.circular(5),   // Radius for top-left corner
      topRight: Radius.circular(5),  // Radius for top-right corner
      bottomLeft: Radius.circular(0), // No radius for bottom-left corner
      bottomRight: Radius.circular(0) // No radius for bottom-right corner
    ); // Border radius of 10
    canvas.drawRRect(roundedNeckRect, paint);

    // Draw the body of the bottle with rounded corners (large rectangle starting at bottom of the neck)
    Rect bodyRect = Rect.fromLTWH(0, neckHeight, size.width, size.height - neckHeight);
    RRect roundedBodyRect = RRect.fromRectAndCorners(
      bodyRect,
      topLeft: Radius.circular(5),   // Radius for top-left corner
      topRight: Radius.circular(5),  // Radius for top-right corner
      bottomLeft: Radius.circular(5), // No radius for bottom-left corner
      bottomRight: Radius.circular(5) // No radius for bottom-right corner
    );// Border radius of 20
    canvas.drawRRect(roundedBodyRect, paint);

    // Paint the water inside the bottle
    double waterHeight = (size.height - neckHeight) * waterLevel;
    Rect waterRect = Rect.fromLTWH(2, size.height + 2 - waterHeight, size.width-4, waterHeight- 4);
    Paint waterPaint = Paint()
      ..color = AppStyles.bottleWaterColor
      ..style = PaintingStyle.fill;

    // Fill the water
    canvas.drawRect(waterRect, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}