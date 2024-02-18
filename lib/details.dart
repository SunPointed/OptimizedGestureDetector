import 'package:flutter/gestures.dart';
import 'package:optimized_gesture_detector/direction.dart';

class OpsMoveStartDetails {
  OpsMoveStartDetails({this.globalPoint = Offset.zero, Offset? localPoint})
      : localPoint = localPoint ?? globalPoint;

  final Offset localPoint;
  final Offset globalPoint;
}

class OpsMoveUpdateDetails {
  OpsMoveUpdateDetails({this.globalPoint = Offset.zero, Offset? localPoint})
      : localPoint = localPoint ?? globalPoint;

  final Offset localPoint;
  final Offset globalPoint;
}

class OpsMoveEndDetails {
  OpsMoveEndDetails(
      {this.velocity = Velocity.zero,
      this.globalPoint = Offset.zero,
      Offset? localPoint})
      : localPoint = localPoint ?? globalPoint;

  final Velocity velocity;
  final Offset localPoint;
  final Offset globalPoint;
}

class OpsScaleStartDetails {
  OpsScaleStartDetails({this.globalPoint = Offset.zero, Offset? localPoint})
      : localPoint = localPoint ?? globalPoint;

  final Offset localPoint;
  final Offset globalPoint;
}

class OpsScaleUpdateDetails {
  OpsScaleUpdateDetails(
      {this.globalFocalPoint = Offset.zero,
      Offset? localFocalPoint,
      Direction? mainDirection,
      this.scale = 1.0,
      this.horizontalScale = 1.0,
      this.verticalScale = 1.0,
      this.rotation = 0.0})
      : localFocalPoint = localFocalPoint ?? globalFocalPoint,
        mainDirection = mainDirection ?? Direction.X;

  final Direction mainDirection;
  final Offset localFocalPoint;
  final Offset globalFocalPoint;
  final double scale;
  final double horizontalScale;
  final double verticalScale;
  final double rotation;
}

class OpsScaleEndDetails {
  OpsScaleEndDetails(
      {this.velocity = Velocity.zero,
      this.globalPoint = Offset.zero,
      Offset? localPoint})
      : localPoint = localPoint ?? globalPoint;

  final Velocity velocity;
  final Offset localPoint;
  final Offset globalPoint;
}
