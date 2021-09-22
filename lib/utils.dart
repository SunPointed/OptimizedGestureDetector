import 'package:flutter/gestures.dart';
import 'package:optimized_gesture_detector/details.dart';
import 'package:optimized_gesture_detector/direction.dart';
import 'package:optimized_gesture_detector/scale.dart';

class Util {
  static const DEBUG = false;

  // ignore: non_constant_identifier_names
  static void L1(String name, Object obj) {
    if (DEBUG) {
      print("${name.toString()}->${obj.toString()}");
    }
  }

  // ignore: non_constant_identifier_names
  static void L2(String name) {
    if (DEBUG) {
      print(name);
    }
  }
}

class DetailsUtils {
  static OpsScaleStartDetails toOpsScaleStartDetails(OpsSStartDetails details) {
    return OpsScaleStartDetails(
        globalPoint: details.focalPoint, localPoint: details.localFocalPoint);
  }

  static OpsScaleUpdateDetails toOpsScaleUpdateDetails(
      OpsSUpdateDetails details, Direction? mainDirection) {
    return OpsScaleUpdateDetails(
        globalFocalPoint: details.focalPoint,
        localFocalPoint: details.localFocalPoint,
        mainDirection: mainDirection,
        scale: details.scale,
        horizontalScale: details.horizontalScale,
        verticalScale: details.verticalScale,
        rotation: details.rotation);
  }

  static OpsScaleEndDetails toOpsScaleEndDetails(
      OpsSEndDetails details, Offset globalPoint, Offset localPoint) {
    return OpsScaleEndDetails(
        velocity: details.velocity,
        globalPoint: globalPoint,
        localPoint: localPoint);
  }

  static OpsMoveStartDetails toOpsMoveStartDetails(OpsSStartDetails details) {
    return OpsMoveStartDetails(
        globalPoint: details.focalPoint, localPoint: details.localFocalPoint);
  }

  static OpsMoveUpdateDetails toOpsMoveUpdateDetails(
      OpsSUpdateDetails details) {
    return OpsMoveUpdateDetails(
        globalPoint: details.focalPoint, localPoint: details.localFocalPoint);
  }

  static OpsMoveEndDetails toOpsMoveEndDetails(
      OpsSEndDetails details, Offset globalPoint, Offset localPoint) {
    return OpsMoveEndDetails(
        velocity: details.velocity,
        globalPoint: globalPoint,
        localPoint: localPoint);
  }
}
