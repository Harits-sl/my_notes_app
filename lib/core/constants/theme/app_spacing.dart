import 'package:flutter/material.dart';

class AppRadius {
  /// Default Border Radius -> 12
  static const double radiusDefault = 12.0;
  static const BorderRadius main = BorderRadius.all(Radius.circular(12));

  static const BorderRadius r4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius r8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius r16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius r24 = BorderRadius.all(Radius.circular(24));
  static const BorderRadius circle = BorderRadius.all(Radius.circular(999));
}

// -------------------------------------

class AppPadding {
  /// Default Padding -> 24
  static const double paddingDefault = 12.0;
  static const EdgeInsets main = EdgeInsets.all(24);

  static const EdgeInsets p4 = EdgeInsets.all(4);
  static const EdgeInsets p8 = EdgeInsets.all(8);
  static const EdgeInsets p12 = EdgeInsets.all(12);
  static const EdgeInsets p16 = EdgeInsets.all(16);
  static const EdgeInsets p32 = EdgeInsets.all(32);

  static const EdgeInsets px24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets py24 = EdgeInsets.symmetric(vertical: 24);
}

// -------------------------------------

class AppMargin {
  /// Default Margin -> 24
  static const double marginDefault = 12.0;
  static const EdgeInsets main = EdgeInsets.all(24);

  static const EdgeInsets m4 = EdgeInsets.all(4);
  static const EdgeInsets m8 = EdgeInsets.all(8);
  static const EdgeInsets m12 = EdgeInsets.all(12);
  static const EdgeInsets m16 = EdgeInsets.all(16);

  static const EdgeInsets mx24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets my24 = EdgeInsets.symmetric(vertical: 24);
}
