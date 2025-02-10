import 'dart:math';

import 'package:flutter/material.dart';

enum NipLocation {
  top,
  right,
  bottom,
  left,
  bottomRight,
  bottomLeft,
  topRight,
  topLeft
}

const defaultNipHeight = 10.0;

class SpeechBalloon extends StatelessWidget {
  const SpeechBalloon({
    super.key,
    required this.child,
    this.nipLocation = NipLocation.bottom,
    this.color = Colors.white,
    this.borderColor,
    this.borderRadius = 2,
    this.innerBorderRadius,
    this.borderWidth = 2,
    this.height = 50,
    this.width = 60,
    this.nipHeight = defaultNipHeight,
    this.offset = Offset.zero,
  });

  /// The [child] contained by the [SpeechBalloon]
  final Widget child;

  /// The location of the nip of the speech bubble.
  ///
  /// Use [NipLocation] enum, either [TOP], [RIGHT], [BOTTOM], or [LEFT].
  /// The nip will automatically center to the side that it is assigned.
  final NipLocation nipLocation;

  /// The color of the body of the [SpeechBalloon] and nip.
  /// Defaultly white.
  final Color color;

  /// The [borderRadius] of the [SpeechBalloon].
  /// The [SpeechBalloon] is built with a
  /// circular border radius on all 4 corners.
  final double borderRadius;

  /// The [innerBorderRadius] of the [SpeechBalloon].
  /// In addition, the radius used in the speechbubble
  /// You may need to specify this radius from
  /// time to time due to the height and width.
  final double? innerBorderRadius;

  /// The [borderColor] of the [SpeechBalloon].
  /// This is the border color of [SpeechBalloon].
  /// Specify the borderColor to display the border.
  /// Defaultly red.
  final Color? borderColor;

  /// The explicitly defined height of the [SpeechBalloon].
  /// The [SpeechBalloon] will defaultly enclose its [child].
  final double height;

  /// The explicitly defined width of the [SpeechBalloon].
  /// The [SpeechBalloon] will defaultly enclose its [child].
  final double width;

  /// The [borderWidth] of the [SpeechBalloon].
  /// Defaultly 2
  final double borderWidth;

  /// The [nipHeight] of the [SpeechBalloon].
  /// Specify the height of nip
  final double nipHeight;

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    Offset? nipOffset;
    Offset? innerNipOffset;
    AlignmentGeometry? alignment;
    final vM = 0.9;
    final hM = 1 - (borderWidth * 0.1);

    final rotatedNipHalfHeight = getNipHeight(nipHeight) / 2;
    final offset = nipHeight / 2 + rotatedNipHalfHeight;
    switch (nipLocation) {
      case NipLocation.top:
        final value = -offset + rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(0, value);
        innerNipOffset = this.offset + Offset(0, value * vM);
        alignment = Alignment.topCenter;
        break;
      case NipLocation.right:
        final value = offset - rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(value, 0);
        innerNipOffset = this.offset + Offset(value * vM, 0);
        alignment = Alignment.centerRight;
        break;
      case NipLocation.bottom:
        final value = offset - rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(0, value);
        innerNipOffset = this.offset + Offset(0, value * vM);
        alignment = Alignment.bottomCenter;
        break;
      case NipLocation.left:
        final value = -offset + rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(value, 0);
        innerNipOffset = this.offset + Offset(value * vM, 0);
        alignment = Alignment.centerLeft;
        break;
      case NipLocation.bottomLeft:
        final value = offset - rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(value, value);
        innerNipOffset = this.offset + Offset(value * hM + 20, value * vM);
        alignment = Alignment.bottomLeft;
        break;
      case NipLocation.bottomRight:
        final value1 = -offset + rotatedNipHalfHeight;
        final value2 = offset - rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(value1, value2);
        innerNipOffset = this.offset + Offset(value1 * hM - 20, value2 * vM);
        alignment = Alignment.bottomRight;
        break;
      case NipLocation.topLeft:
        final value1 = offset - rotatedNipHalfHeight;
        final value2 = -offset + rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(value1, value2);
        innerNipOffset = this.offset + Offset(value1 * hM, value2 * vM);
        alignment = Alignment.topLeft;
        break;
      case NipLocation.topRight:
        final value1 = -offset + rotatedNipHalfHeight;
        final value2 = -offset + rotatedNipHalfHeight;
        nipOffset = this.offset + Offset(value1, value2);
        innerNipOffset = this.offset + Offset(value1 * hM, value2 * vM);
        alignment = Alignment.topRight;
        break;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        if (borderColor != null)
          Stack(
            alignment: alignment,
            children: [
              nip(nipOffset),
              balloon(),
            ],
          ),
        Stack(
          alignment: alignment,
          children: [
            frontNip(innerNipOffset),
            frontBalloon(),
          ],
        ),
      ],
    );
  }

  Widget frontBalloon() {
    late double innerHeight = height;
    late double innerWidth = width;
    late double innerRadius = borderRadius;
    if (borderColor != null) {
      innerHeight = height - borderWidth;
      innerWidth = width - borderWidth;
      innerRadius = innerBorderRadius ?? borderRadius * 0.9;
    }

    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(innerRadius),
      ),
      color: color,
      child: SizedBox(
        height: innerHeight,
        width: innerWidth,
        child: child,
      ),
    );
  }

  Widget frontNip(Offset nipOffset) {
    return Transform.translate(
      offset: nipOffset,
      child: RotationTransition(
        turns: const AlwaysStoppedAnimation(45 / 360),
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(1),
          ),
          color: color,
          child: SizedBox(
            height: nipHeight,
            width: nipHeight,
          ),
        ),
      ),
    );
  }

  Widget balloon() {
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      color: borderColor,
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }

  Widget nip(Offset nipOffset) {
    return Transform.translate(
      offset: nipOffset,
      child: RotationTransition(
        turns: const AlwaysStoppedAnimation(45 / 360),
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(1.5),
          ),
          color: borderColor,
          child: SizedBox(
            height: nipHeight,
            width: nipHeight,
          ),
        ),
      ),
    );
  }

  double getNipHeight(double nipHeight) => sqrt(2 * pow(nipHeight, 2));
}