import 'package:flutter/material.dart' show Alignment, AssetImage, BoxDecoration, BoxFit, BuildContext, Container, DecorationImage, EdgeInsets, GestureDetector, GridView, Key, MaterialApp, MediaQuery, Navigator, Orientation, Scaffold, StatelessWidget, Text, Widget, required, runApp;
import 'package:valladolid_multiapp/Calculator.dart' show Calculator;
import 'package:valladolid_multiapp/Figures.dart' show Figures;
import 'package:valladolid_multiapp/Resources.dart' show Resources;
import 'package:valladolid_multiapp/Vodcast.dart' show Vodcast;
import 'package:valladolid_multiapp/style.dart';

/// Create a button for [HomePage] to push toward a new view.
///
/// [GestureDetector] is used to use [onTap] method and enables to superpose text above image.
class HomeButton extends GestureDetector{
  /// The button contains one [image] and the [name] to know this action.
  /// The new view which controlled by the button is defined with the [pathView]
  HomeButton(name, context, {Key key, @required image, @required pathView}) : super (
    key: key,
    child: Container(
      child: Text(name, style: Style.textStyle),
      alignment: Alignment.bottomCenter,
      //Padding adds a white space between text
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover
        ),
      ),
    ),
    onTap: () => Navigator.pushNamed(context, pathView)
  );
}

/// Define the new main function to start the first view
void main() => runApp(App());

/// [App] class defines characteristics of application
///
/// First, this class defines the general theme. A custom abstract [Style] class is used for this.
/// Next, routes are defined. This creates a short name to redirect views. There are one dart file for each route (with the same name)
/// Then, the default route starts [HomePage] view. This class is defined below in this file.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Style.theme,
      home: HomePage(),
      routes : {
        '/vodcast': (context) => Vodcast(),
        '/resources': (context) => Resources(),
        '/calculator': (context) => Calculator(),
        '/figures': (context) => Figures(),
      }
    );
  }
}

/// [HomePage] class defines the default view when application is started
///
/// Display 4 buttons to redirect in others views
/// Layout depends on orientation of device
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle('Mi App'),
      body: GridView.count(
        //Adapt view for portrait and landscape orientation
        crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
        children: <Widget>[
          HomeButton("Vodcasts", context, image: 'res/Podcast.png', pathView: '/vodcast'),
          HomeButton("Resources", context, image: 'res/resources.png', pathView: '/resources'),
          HomeButton("Calculator", context, image: 'res/calculator.png', pathView: '/calculator'),
          HomeButton("Figures", context, image: 'res/figures.png', pathView: '/figures')
        ],
      )
    );
  }
}
