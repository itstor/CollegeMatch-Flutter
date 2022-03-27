import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

import 'package:get/get.dart';

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;
  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

class CurveWave extends Curve {
  const CurveWave();
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return sin(t * pi);
  }
}

class FindingWidget extends StatefulWidget {
  FindingWidget({Key? key}) : super(key: key);

  @override
  State<FindingWidget> createState() => _FindingWidgetState();
}

class _FindingWidgetState extends State<FindingWidget>
    with TickerProviderStateMixin {
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            painter: CirclePainter(
              animController,
              color: Color(0xFFA989FF),
            ),
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/icons/search-partner-icon.png'),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Finding your partner...',
            style: Get.textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
