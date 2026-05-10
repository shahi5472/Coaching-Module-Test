import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../utils/constansts/color_constants.dart';

class CircleProgressBar extends StatefulWidget {
  final double targetPercentage;
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Color textColor;
  final Duration duration;

  const CircleProgressBar({
    super.key,
    required this.targetPercentage,
    this.size = 100.0,
    this.strokeWidth = 10.0,
    this.backgroundColor = Colors.black,
    this.progressColor = primaryColor,
    this.textColor = primaryColor,
    this.duration = const Duration(seconds: 1),
  }) : assert(targetPercentage >= 0.0 && targetPercentage <= 1.0, 'targetPercentage must be between 0.0 and 1.0');

  @override
  State<CircleProgressBar> createState() => _CircleProgressBarState();
}

class _CircleProgressBarState extends State<CircleProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _setupAnimation(0.0, widget.targetPercentage);
    _animationController.forward();
  }

  void _setupAnimation(double begin, double end) {
    _animation =
        Tween<double>(begin: begin, end: end).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void didUpdateWidget(covariant CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetPercentage != oldWidget.targetPercentage || widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
      _animationController.stop();
      _setupAnimation(_animation.value, widget.targetPercentage);
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _CircleProgressBarPainter(
          progress: _animation.value,
          strokeWidth: widget.strokeWidth,
          backgroundColor: widget.backgroundColor,
          progressColor: widget.progressColor,
          textColor: widget.textColor,
          size: widget.size,
        ),
      ),
    );
  }
}

class _CircleProgressBarPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Color textColor;
  final double size;

  _CircleProgressBarPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    required this.textColor,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${(progress * 100).toInt()}%',
        style: TextStyle(
          color: textColor,
          fontSize: size.width * 0.2,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(_CircleProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.textColor != textColor ||
        oldDelegate.size != size;
  }
}
