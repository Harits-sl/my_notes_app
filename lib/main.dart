import 'package:flutter/material.dart';
import 'app.dart';
import 'locator.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}
