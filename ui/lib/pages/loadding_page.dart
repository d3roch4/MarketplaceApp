import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:turbine/pages/error_page.dart';

class LoaddingPage extends StatelessWidget {
  static Widget future<T>({
    required Future<T> future,
    required Widget Function(T? data) builder,
  }) {
    return FutureBuilder<T>(
      future: future,
      builder: (c, s) => _builder(c, s, builder),
    );
  }

  static _builder<T>(
    BuildContext c, AsyncSnapshot<T> snap, Widget Function(T? data) builder
  ) {
    return snap.connectionState == ConnectionState.waiting
        ? LoaddingPage()
        : snap.hasError
            ? ErrorPage(
                message: snap.error.toString(), stackTrace: snap.stackTrace ?? StackTrace.current)
            : builder(snap.data);
  }

  static Widget stream<T>({
    required Stream<T> stream,
    required Widget Function(T? data) builder,
  }) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (c, s) => _builder(c, s, builder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loadding".tr)),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
