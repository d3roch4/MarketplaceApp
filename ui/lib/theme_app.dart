import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  var buttonTheme = ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      textTheme: ButtonTextTheme.primary
  );
  var outlinedButtonTheme = OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ));
  var elevetedButtonTheme = ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ));
  var bottomAppBarTheme = BottomAppBarTheme(
    color: Colors.orangeAccent,
    elevation: 16,
    shape: AutomaticNotchedShape(
        RoundedRectangleBorder(),
        GetPlatform.isWeb? null: StadiumBorder(side: BorderSide())
    ),
  );

  ThemeData light() => ThemeData(
    brightness: Brightness.light,
    buttonTheme: buttonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    elevatedButtonTheme: elevetedButtonTheme,
    bottomAppBarTheme: bottomAppBarTheme,
    dividerTheme: !GetPlatform.isWeb? null: DividerThemeData(color: Colors.grey, space: 2)
  );

  ThemeData dark() => ThemeData(
      brightness: Brightness.dark,
      bottomAppBarTheme: bottomAppBarTheme.copyWith(color: Colors.white10),
      dividerColor: Colors.white60,
      buttonTheme: buttonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      elevatedButtonTheme: elevetedButtonTheme,
      dividerTheme: !GetPlatform.isWeb? null: DividerThemeData(color: Colors.grey, space: 2)
    );
}