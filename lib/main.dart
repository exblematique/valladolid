import 'package:flutter/material.dart';
import 'package:valladolid_multiapp/Calculator.dart';
import 'package:valladolid_multiapp/Figures.dart';
import 'package:valladolid_multiapp/Resources.dart';
import 'package:valladolid_multiapp/Vodcast.dart';
import 'package:valladolid_multiapp/style.dart';

void main() => runApp(MyApp());

/**
 * Create button for home which contains image and text
 * @param name of button
 * @param img contain the image to display
 * @param pathView to go when the button pressed
 */
class HomeButton extends GestureDetector{
  HomeButton(name, context, {Key key, @required img, @required pathView}) : super (
    key: key,
    child: Container(
      child: Text(name, style: Style.textStyle),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover
        ),//, height: 100, width: 100),
      ),
    ),
    onTap: () => Navigator.pushNamed(context, pathView)
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: Style.theme,
      home: MyHomePage(title: 'Mi App'),
      routes : {
        '/vodcast': (context) => Vodcast(),
        '/resources': (context) => Resources(),
        '/calculator': (context) => Calculator(),
        '/figures': (context) => Figures(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            child: Text(widget.title),
            alignment: Alignment.center
        ),
      ),
      body: GridView.count(
        //Adapt view for portrait and landscape
        crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
        children: <Widget>[
          HomeButton("Vodcasts", context, img: 'res/Podcast.png', pathView: '/vodcast'),
          HomeButton("Resources", context, img: 'res/resources.png', pathView: '/resources'),
          HomeButton("Calculator", context, img: 'res/calculator.png', pathView: '/calculator'),
          HomeButton("Figures", context, img: 'res/figures.png', pathView: '/figures')
        ],
      )
    );
  }
}
