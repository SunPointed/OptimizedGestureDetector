import 'package:flutter/gestures.dart';
import 'package:optimized_gesture_detector/details.dart';

typedef OpsTapDownCallback = void Function(TapDownDetails details);

typedef OpsTapCancelCallback = void Function();

typedef OpsSingleTapUpCallback = void Function(TapUpDetails details);

typedef OpsDoubleTapUpCallback = void Function(TapUpDetails details);

typedef OpsDragStartCallback = void Function(LongPressStartDetails details);

typedef OpsDragUpdateCallback = void Function(
    LongPressMoveUpdateDetails details);

typedef OpsDragEndCallback = void Function(LongPressEndDetails details);

typedef OpsMoveStartCallback = void Function(OpsMoveStartDetails details);

typedef OpsMoveCancelCallback = void Function();

typedef OpsMoveUpdateCallback = void Function(OpsMoveUpdateDetails details);

typedef OpsMoveEndCallback = void Function(OpsMoveEndDetails details);

typedef OpsScaleStartCallback = void Function(OpsScaleStartDetails details);

typedef OpsScaleCancelCallback = void Function();

typedef OpsScaleUpdateCallback = void Function(OpsScaleUpdateDetails details);

typedef OpsScaleEndCallback = void Function(OpsScaleEndDetails details);
