import 'package:flutter/material.dart';
///
/// This class defines all variables needed to change style of application
///
abstract class Style {
  static Color mainColor = Color.fromRGBO(31, 184, 203, 1);

  static ThemeData theme = ThemeData(
    primaryColor: mainColor,
    visualDensity: VisualDensity.adaptivePlatformDensity
  );

  static TextStyle textStyle = TextStyle(color: mainColor);
}

/// Create a new object for all AppBar
class AppBarStyle extends AppBar {
  AppBarStyle(String title, {key})
    : super (
      key: key,
      title: Container(
        child: Text(title, style: TextStyle(color: Colors.white)),
        alignment: Alignment.center
      ),
    );
}