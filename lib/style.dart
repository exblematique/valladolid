import 'package:flutter/material.dart' show AppBar, Color, Colors, IconThemeData, Text, TextStyle, ThemeData, VisualDensity;

///
/// The theme of application can be updated directly from this file.
///

/// This class defines all variables needed to change style of application
abstract class Style {
  /// This is a main color of application
  static Color mainColor = Color.fromRGBO(31, 184, 203, 1);

  /// This is a main color for text and icon in drawer
  static Color textIconColor = Colors.white;

  /// This is theme defined for the application in main dart file
  static ThemeData theme = ThemeData(
    primaryColor: mainColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonColor: textIconColor,
    splashColor: textIconColor
  );

  /// This is a theme for all texts in application
  static TextStyle textStyle = TextStyle(color: mainColor);
}

/// A new object for all AppBar in application
class AppBarStyle extends AppBar {
  /// Create a new object for all AppBar
  AppBarStyle(String title, {key})
    : super (
      key: key,
      title: Text(title, style: TextStyle(color: Style.textIconColor)),
      centerTitle: true,
      iconTheme: IconThemeData(color: Style.textIconColor)
    );
}