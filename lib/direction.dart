import 'dart:ui';

enum Direction { X, Y }

Direction getCurrentDirection(Offset p1, Offset p2) {
  var xRes = (p1.dx - p2.dx).abs();
  var yRes = (p1.dy - p2.dy).abs();
  return xRes >= yRes ? Direction.X : Direction.Y;
}
