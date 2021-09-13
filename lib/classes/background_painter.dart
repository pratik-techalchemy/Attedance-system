import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'dart:math';

import 'palette.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({@required Animation<double> animation})
      : bluePaint = Paint()
          ..color = Palette.lightBlue
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = Palette.darkBlue
          ..style = PaintingStyle.fill,
        orangePaint = Paint()
          ..color = Palette.orange
          ..style = PaintingStyle.fill,
        linePaint = Paint()
          ..color = Colors.orange.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        orangeAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.6,
            curve: Interval(0, 0.7, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        greyAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        blueAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> blueAnim;
  final Animation<double> greyAnim;
  final Animation<double> orangeAnim;

  final Paint linePaint;
  final Paint bluePaint;
  final Paint greyPaint;
  final Paint orangePaint;

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(canvas, size);
    paintGrey(size, canvas);
    paintOrange(size, canvas);
  }

  void paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.lineTo(0, 0);
    final ld0w3 = lerpDouble(0, size.width / 3, blueAnim.value);
    final ld0h = lerpDouble(0, size.height, blueAnim.value);
    final ldw2w43 =
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value);
    final ldh2h43 =
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value);

    path.lineTo(
      0,
      ld0h,
    );
    _addPointsToPath(path, [
      Point(
        ld0w3,
        ld0h,
      ),
      Point(ldw2w43, ldh2h43),
      Point(size.width, ldh2h43),
    ]);

    canvas.drawPath(path, bluePaint);
  }

  void paintGrey(Size size, Canvas canvas) {
    final path = Path();

    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    final ldh4h2 = lerpDouble(
      size.height / 4,
      size.height / 2,
      greyAnim.value,
    );
    final ldh4h22 = lerpDouble(
      size.height / 4,
      size.height / 2,
      liquidAnim.value,
    );
    final ldh2h34 =
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value);
    final ldh6h3 = lerpDouble(size.height / 6, size.height / 3, greyAnim.value);
    final ldh5h4 = lerpDouble(size.height / 5, size.height / 4, greyAnim.value);
    path.lineTo(
      0,
      ldh4h2 ,
    );
    _addPointsToPath(
      path,
      [
        Point(
          size.width / 4,
          ldh2h34 ,
        ),
        Point(
          size.width * 3 / 5,
          ldh4h22 ,
        ),
        Point(
          size.width * 4 / 5,
          ldh6h3 ,
        ),
        Point(
          size.width,
          ldh5h4 ,
        ),
      ],
    );

    canvas.drawPath(path, greyPaint);
  }

  void paintOrange(Size size, Canvas canvas) {
    if (orangeAnim.value > 0) {
      final path = Path();
      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      
      final ld0h12 = lerpDouble(
        0,
        size.height / 12,
        orangeAnim.value,
      );
      final ld0h6 = lerpDouble(
        0,
        size.height / 6,
        liquidAnim.value,
      );
      final ld0h10 = lerpDouble(0, size.height / 10, liquidAnim.value);
      final ld0h8 = lerpDouble(0, size.height / 8, liquidAnim.value);

      path.lineTo(
        0,
        ld0h12 ,
      );

      _addPointsToPath(path, [
        Point(
          size.width / 7,
          ld0h6 ,
        ),
        Point(
          size.width / 3,
          ld0h10 ,
        ),
        Point(
          size.width / 3 * 2,
          ld0h8 ,
        ),
        Point(
          size.width * 3 / 4,
          0,
        ),
      ]);

      canvas.drawPath(path, orangePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path');
    }

    for (int i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
