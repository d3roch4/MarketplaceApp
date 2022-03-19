import 'package:flutter/material.dart';

abstract class MainPageBase extends StatefulWidget {
  late _MainPageBaseState state;
  MainPageBase();

  Widget? leading()=> null;
  List<Widget>? actions()=> null;
  Widget build(BuildContext context);

  void setState(VoidCallback fn) {
    state.setState(fn);
  }

  @override
  State<MainPageBase> createState()=> state = _MainPageBaseState();
}

class _MainPageBaseState extends State<MainPageBase> {
  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
