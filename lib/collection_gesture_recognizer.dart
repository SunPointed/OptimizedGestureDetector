import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class CollectionGestureRecognizer extends OneSequenceGestureRecognizer {
  final List<GestureRecognizerFactory> members =
      <GestureRecognizerFactory>[];

  void addRecognizer(GestureRecognizerFactory factory) {
    if (!members.contains(factory)) members.add(factory);
  }

  void removeRecognizer(GestureRecognizerFactory factory) {
    if (members.contains(factory)) members.remove(factory);
  }


  @override
  void acceptGesture(int pointer) {
    members.forEach((f) {
      var recognizer = f.constructor();
      f.initializer(recognizer);
      recognizer.acceptGesture(pointer);
    });
  }

  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }

  @override
  // TODO: implement debugDescription
  String get debugDescription => null;

  @override
  void didStopTrackingLastPointer(int pointer) {
    // TODO: implement didStopTrackingLastPointer
  }

  @override
  void handleEvent(PointerEvent event) {
    // TODO: implement handleEvent
  }
}
