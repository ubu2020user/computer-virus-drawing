import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlowVirusPainter extends CustomPainter {
  final int _currentStep;
  final int _totalSteps;

  SlowVirusPainter(this._currentStep, this._totalSteps);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue// Yellow
      ..strokeWidth = 2.0;

    // canvas.drawColor(Color, BlendMode.srcOver); // Grey background

    double x = size.width / 2;
    double y = size.height / 4;
    double angle = 0.0;
    double forwardDistance = 0.0;
    double rotationAngle = 0.0;

    for (int i = 0; i < _currentStep; i++) {
      canvas.drawLine(
        Offset(x, y),
        Offset(
          x + forwardDistance * cos(angle * (pi / 180)),
          y + forwardDistance * sin(angle * (pi / 180)),
        ),
        paint,
      );

      x += forwardDistance * cos(angle * (pi / 180));
      y += forwardDistance * sin(angle * (pi / 180));
      angle += rotationAngle;
      forwardDistance += 3.0;
      rotationAngle += 1.0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! SlowVirusPainter ||
        oldDelegate._currentStep != _currentStep;
  }
}

class VirusPainterWidget extends StatefulWidget {
  const VirusPainterWidget({Key? key}) : super(key: key);

  @override
  State<VirusPainterWidget> createState() => _VirusPainterWidgetState();
}

class _VirusPainterWidgetState extends State<VirusPainterWidget> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    const totalSteps = 210;
    for (int i = 0; i <= totalSteps; i++) {
      await Future.delayed(const Duration(milliseconds: 20)); // Adjust delay as needed
      setState(() {
        _currentStep = i;
      });
    }
    print('Animation took ${DateTime.now().millisecondsSinceEpoch - timeStamp} ms');
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SlowVirusPainter(_currentStep, 210),
      size: Size.infinite,
    );
  }
}