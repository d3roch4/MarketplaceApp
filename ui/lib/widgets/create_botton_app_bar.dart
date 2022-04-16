import 'package:flutter/material.dart';

BottomAppBar createBottomAppBar(Widget child) {
  return BottomAppBar(
      child: Padding(
    padding: EdgeInsets.all(10),
    child: child,
  ));
}
