import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valladolid_multiapp/style.dart';

///
/// This file defines all action in Figures part for this application
///

/// Entry point of the widget [Figures]
class Figures extends StatefulWidget {
  const Figures({Key key}) : super(key:key);

  @override
  _FiguresState createState() => _FiguresState();
}

/// Defines state for [Figures] class
class _FiguresState extends State<Figures>{
  /// List of figures available for this application
  ///
  /// The first string contains the name of figure to display in application.
  /// The second string is the path of image in resource folder
  Map<String, String> figures = {
    'Chapter 1.2 Anatomy and Surface Anatomy': 'res/M1C1S2a.png',
    'Chapter 1.2 Posterior View of the Liver': 'res/M1C1S2f.png',
    'Chapter 2.1 Liver with numbers': 'res/DoodleFigure.png'
  };

  /// Name of the current image displaying
  ///
  /// The name is one key from [figures] variable
  String currentImageName;

  /// Image object of the current image displaying
  ///
  /// This image is created from one value from [figures] variable
  Image currentImage;

  @override
  void initState(){
    //Select the first image from figure variable and display it
    currentImage = Image.asset(figures.values.first);
    currentImageName = figures.keys.first;
    super.initState();
  }

  Widget build(BuildContext context){
    // This objects contains all elements in Drawer menu
    List<Widget> drawerList = new List<Widget>();

    // Create a beautiful header for drawer
    drawerList.add(DrawerHeader(
      child: Text('LIST OF AVAILABLE FIGURES', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
      decoration: BoxDecoration(
        color: Style.mainColor,
      ),
      padding: EdgeInsets.all(75),
    ));

    // Add return entry on drawer list 
    drawerList.add(ListTile(
      title: Row(children: [Icon(Icons.arrow_back), Text(" BACK")]),
      onTap: () {
        // Close drawer
        Navigator.pop(context);
        // Return to previous page
        Navigator.pop(context);
    }));

    // This function create an entry in drawer for each value in figures variable
    // Then close Drawer
    figures.entries.forEach((e) {
      drawerList.add(ListTile(
        title: Text(e.key),
        onTap: () => setState(() {
          currentImage = Image.asset(e.value);
          currentImageName = e.key;
          Navigator.pop(context);
        }),
      ));
    });

    // Return the page
    // Defines the drawer
    // Change automatically the name of view according to image currently displaying
    return Scaffold(
      appBar: AppBarStyle(currentImageName),
      drawer: Drawer(
        child: ListView(
          children: drawerList
        )
      ),
      body: currentImage
    );
  }
}