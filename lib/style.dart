import 'package:flutter/material.dart' show AppBar, Color, Colors, IconThemeData, Text, TextStyle, ThemeData, VisualDensity;

///
/// This class defines all variables needed to change style of application
///
abstract class Style {
  static Color mainColor = Color.fromRGBO(31, 184, 203, 1);
  static Color textIconColor = Colors.white;
  static ThemeData theme = ThemeData(
    primaryColor: mainColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonColor: textIconColor,
    splashColor: textIconColor
  );

  static TextStyle textStyle = TextStyle(color: mainColor);
}

/// Create a new object for all AppBar
class AppBarStyle extends AppBar {
  AppBarStyle(String title, {key})
    : super (
      key: key,
      title: Text(title, style: TextStyle(color: Style.textIconColor)),
      centerTitle: true,
      iconTheme: IconThemeData(color: Style.textIconColor)
    );
}