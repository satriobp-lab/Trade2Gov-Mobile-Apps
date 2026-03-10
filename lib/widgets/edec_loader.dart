import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class EdecLoader extends StatefulWidget {
  const EdecLoader({super.key});

  @override
  State<EdecLoader> createState() => _EdecLoaderState();
}

class _EdecLoaderState extends State<EdecLoader>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [

          /// ROTATING LINES
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: CustomPaint(
                  size: const Size(70, 70),
                  painter: LoaderPainter(),
                ),
              );
            },
          ),

          /// CENTER IMAGE (CIRCLE)
          ClipOval(
            child: Image.asset(
              'assets/images/e-declaration.jpg',
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class LoaderPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = AppColors.customColorRed
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final radius = size.width / 2;

    final rect = Rect.fromCircle(
      center: Offset(radius, radius),
      radius: radius - 4,
    );

    /// GARIS PANJANG
    canvas.drawArc(
      rect,
      -pi / 2,
      0.9,
      false,
      paint,
    );

    /// GARIS SEDANG
    canvas.drawArc(
      rect,
      -pi / 2 + 1.2,
      0.55,
      false,
      paint,
    );

    /// GARIS PENDEK
    canvas.drawArc(
      rect,
      -pi / 2 + 2,
      0.3,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}