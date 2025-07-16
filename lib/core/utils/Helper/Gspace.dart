import 'package:flutter/material.dart';

class Gspace {
  Gspace._();

  static Widget spaceVertical(double height) {
    return SizedBox(height: height);
  }

  static Widget spaceHorizontal(double width) {
    return SizedBox(width: width);
  }
}
