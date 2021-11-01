import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:optimized_gesture_detector/scale.dart' as scale;

class CoreGestureDetector extends StatelessWidget {
  CoreGestureDetector(
      {Key? key,
      this.child,
      this.onTapDown,
      this.onTapUp,
      this.onTapCancel,
      this.onLongPressStart,
      this.onLongPressMoveUpdate,
      this.onLongPressEnd,
      this.onScaleStart,
      this.onScaleUpdate,
      this.onScaleEnd,
      this.behavior,
      this.excludeFromSemantics = false,
      this.dragStartBehavior = DragStartBehavior.start,
      this.canHDragDown,
      this.canVDragDown})
      : assert(excludeFromSemantics != null),
        assert(dragStartBehavior != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;

  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;

  final scale.GestureScaleStartCallback? onScaleStart;
  final scale.GestureScaleUpdateCallback? onScaleUpdate;
  final scale.GestureScaleEndCallback? onScaleEnd;

//  /// The pointer is in contact with the screen and has pressed with sufficient
//  /// force to initiate a force press. The amount of force is at least
//  /// [ForcePressGestureRecognizer.startPressure].
//  ///
//  /// Note that this callback will only be fired on devices with pressure
//  /// detecting screens.
//  final GestureForcePressStartCallback onForcePressStart;
//
//  /// The pointer is in contact with the screen and has pressed with the maximum
//  /// force. The amount of force is at least
//  /// [ForcePressGestureRecognizer.peakPressure].
//  ///
//  /// Note that this callback will only be fired on devices with pressure
//  /// detecting screens.
//  final GestureForcePressPeakCallback onForcePressPeak;
//
//  /// A pointer is in contact with the screen, has previously passed the
//  /// [ForcePressGestureRecognizer.startPressure] and is either moving on the
//  /// plane of the screen, pressing the screen with varying forces or both
//  /// simultaneously.
//  ///
//  /// Note that this callback will only be fired on devices with pressure
//  /// detecting screens.
//  final GestureForcePressUpdateCallback onForcePressUpdate;
//
//  /// The pointer is no longer in contact with the screen.
//  ///
//  /// Note that this callback will only be fired on devices with pressure
//  /// detecting screens.
//  final GestureForcePressEndCallback onForcePressEnd;

  /// How this gesture detector should behave during hit testing.
  ///
  /// This defaults to [HitTestBehavior.deferToChild] if [child] is not null and
  /// [HitTestBehavior.translucent] if child is null.
  final HitTestBehavior? behavior;

  /// Whether to exclude these gestures from the semantics tree. For
  /// example, the long-press gesture for showing a tooltip is
  /// excluded because the tooltip itself is included in the semantics
  /// tree directly and so having a gesture to show it would result in
  /// duplication of information.
  final bool excludeFromSemantics;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], gesture drag behavior will
  /// begin upon the detection of a drag gesture. If set to
  /// [DragStartBehavior.down] it will begin when a down event is first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// Only the [onStart] callbacks for the [VerticalDragGestureRecognizer],
  /// [HorizontalDragGestureRecognizer] and [PanGestureRecognizer] are affected
  /// by this setting.
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;

  final GestureArenaTeam _team = GestureArenaTeam();

  final CanDragDownFunction? canHDragDown;
  final CanDragDownFunction? canVDragDown;

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};

    if (onTapDown != null || onTapUp != null || onTapCancel != null) {
      gestures[TapGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
        () => TapGestureRecognizer(debugOwner: this),
        (TapGestureRecognizer instance) {
          instance
            ..onTapDown = onTapDown
            ..onTapUp = onTapUp
            ..onTapCancel = onTapCancel;
        },
      );
    }

    if (onLongPressStart != null ||
        onLongPressMoveUpdate != null ||
        onLongPressEnd != null) {
      gestures[LongPressGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
        () => LongPressGestureRecognizer(debugOwner: this),
        (LongPressGestureRecognizer instance) {
          instance
            ..onLongPressStart = onLongPressStart
            ..onLongPressMoveUpdate = onLongPressMoveUpdate
            ..onLongPressEnd = onLongPressEnd;
        },
      );
    }

    if (onScaleStart != null || onScaleUpdate != null || onScaleEnd != null) {
      gestures[scale.OpsScaleGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<scale.OpsScaleGestureRecognizer>(
        () => scale.OpsScaleGestureRecognizer(debugOwner: this),
        (scale.OpsScaleGestureRecognizer instance) {
          _team.captain = instance;
          if (instance.team == null) {
            instance.team = _team;
          }
          instance
            ..onStart = onScaleStart
            ..onUpdate = onScaleUpdate
            ..onEnd = onScaleEnd;
        },
      );
    }

    gestures[HorizontalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
      () => HorizontalDragGestureRecognizer(debugOwner: this),
      (HorizontalDragGestureRecognizer instance) {
        if (instance.team == null) {
          instance.team = _team;
        }
        instance
          ..onDown = _gestureHDragDownCallback()
          ..onCancel = null
          ..onStart = null
          ..onUpdate = null
          ..onEnd = null;
      },
    );

    gestures[VerticalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer(debugOwner: this),
      (VerticalDragGestureRecognizer instance) {
        if (instance.team == null) {
          instance.team = _team;
        }
        instance
          ..onDown = _gestureVDragDownCallback()
          ..onCancel = null
          ..onStart = null
          ..onUpdate = null
          ..onEnd = null;
      },
    );

    return RawGestureDetector(
      gestures: gestures,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      child: child,
    );
  }

  GestureDragDownCallback? _gestureVDragDownCallback() {
    if (canVDragDown == null) return null;

    return canVDragDown!() ? (e) {} : null;
  }

  GestureDragDownCallback? _gestureHDragDownCallback() {
    if (canHDragDown == null) return null;

    return canHDragDown!() ? (e) {} : null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        EnumProperty<DragStartBehavior>('startBehavior', dragStartBehavior));
  }
}

typedef CanDragDownFunction = bool Function();
