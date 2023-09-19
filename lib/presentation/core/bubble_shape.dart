import 'dart:math';

import 'package:flutter/material.dart';

enum TooltipDirection { down, up }

class BubbleShape extends ShapeBorder {
  const BubbleShape({
    required this.preferredDirection,
    required this.target,
    required this.borderRadius,
    required this.arrowBaseWidth,
    required this.arrowTipDistance,
    required this.borderColor,
    required this.borderWidth,
  });

  final Offset target;
  final double arrowBaseWidth;
  final double arrowTipDistance;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  // final double? left, top, right, bottom;
  final TooltipDirection preferredDirection;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path()
    ..fillType = PathFillType.evenOdd
    ..addPath(getOuterPath(rect), Offset.zero);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    //
    late double topLeftRadius,
        topRightRadius,
        bottomLeftRadius,
        bottomRightRadius;

    Path getLeftTopPath(Rect rect) => Path()
      ..moveTo(rect.left, rect.bottom - bottomLeftRadius)
      ..lineTo(rect.left, rect.top + topLeftRadius)
      ..arcToPoint(
        Offset(rect.left + topLeftRadius, rect.top),
        radius: Radius.circular(topLeftRadius),
      )
      ..lineTo(rect.right - topRightRadius, rect.top)
      ..arcToPoint(
        Offset(rect.right, rect.top + topRightRadius),
        radius: Radius.circular(topRightRadius),
        clockwise: true,
      );

    Path getBottomRightPath(Rect rect) => Path()
      ..moveTo(rect.left + bottomLeftRadius, rect.bottom)
      ..lineTo(rect.right - bottomRightRadius, rect.bottom)
      ..arcToPoint(
        Offset(rect.right, rect.bottom - bottomRightRadius),
        radius: Radius.circular(bottomRightRadius),
        clockwise: false,
      )
      ..lineTo(rect.right, rect.top + topRightRadius)
      ..arcToPoint(
        Offset(rect.right - topRightRadius, rect.top),
        radius: Radius.circular(topRightRadius),
        clockwise: false,
      );

    ///Limits border radius to 25 max
    topLeftRadius = min(borderRadius, 25);
    topRightRadius = min(borderRadius, 25);
    bottomLeftRadius = min(borderRadius, 25);
    bottomRightRadius = min(borderRadius, 25);

    switch (preferredDirection) {
      case TooltipDirection.down:
        return getBottomRightPath(rect)
          ..lineTo(
            min(
              max(
                target.dx + arrowBaseWidth / 2,
                rect.left + borderRadius + arrowBaseWidth,
              ),
              rect.right - topRightRadius,
            ),
            rect.top,
          )
          ..lineTo(target.dx, target.dy + arrowTipDistance) // up to arrow tip
          ..lineTo(
            max(
              min(
                target.dx - arrowBaseWidth / 2,
                rect.right - topLeftRadius - arrowBaseWidth,
              ),
              rect.left + topLeftRadius,
            ),
            rect.top,
          ) //  down /

          ..lineTo(rect.left + topLeftRadius, rect.top)
          ..arcToPoint(
            Offset(rect.left, rect.top + topLeftRadius),
            radius: Radius.circular(topLeftRadius),
            clockwise: false,
          )
          ..lineTo(rect.left, rect.bottom - bottomLeftRadius)
          ..arcToPoint(
            Offset(rect.left + bottomLeftRadius, rect.bottom),
            radius: Radius.circular(bottomLeftRadius),
            clockwise: false,
          );

      case TooltipDirection.up:
        return getLeftTopPath(rect)
          ..lineTo(rect.right, rect.bottom - bottomRightRadius)
          ..arcToPoint(Offset(rect.right - bottomRightRadius, rect.bottom),
              radius: Radius.circular(bottomRightRadius), clockwise: true)
          ..lineTo(
              min(
                  max(target.dx + arrowBaseWidth / 2,
                      rect.left + bottomLeftRadius + arrowBaseWidth),
                  rect.right - bottomRightRadius),
              rect.bottom)

          // up to arrow tip   \
          ..lineTo(target.dx, target.dy - arrowTipDistance)

          //  down /
          ..lineTo(
              max(
                  min(target.dx - arrowBaseWidth / 2,
                      rect.right - bottomRightRadius - arrowBaseWidth),
                  rect.left + bottomLeftRadius),
              rect.bottom)
          ..lineTo(rect.left + bottomLeftRadius, rect.bottom)
          ..arcToPoint(Offset(rect.left, rect.bottom - bottomLeftRadius),
              radius: Radius.circular(bottomLeftRadius), clockwise: true)
          ..lineTo(rect.left, rect.top + topLeftRadius)
          ..arcToPoint(Offset(rect.left, rect.top + topLeftRadius),
              radius: Radius.circular(topLeftRadius), clockwise: true);

      default:
        throw ArgumentError(preferredDirection);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    var paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(getOuterPath(rect), paint);

    paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
  }

  @override
  ShapeBorder scale(double t) {
    return BubbleShape(
      preferredDirection: preferredDirection,
      target: target,
      borderRadius: borderRadius,
      arrowBaseWidth: arrowBaseWidth,
      arrowTipDistance: arrowTipDistance,
      borderColor: borderColor,
      borderWidth: borderWidth,
    );
  }
}
