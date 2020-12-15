import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valladolid_multiapp/style.dart';

/// A [InputWidget] class to define with a unique design for all inputs
///
/// Create a line with an icon, a [name], a input to change data and units.
/// Units is optional
class InputWidget extends Row {
  /// Name to display for this information
  String name;

  /// Unit for this class, if needed
  String units;

  /// Create a [InputWidget] class to define with a unique way all inputs
  ///
  /// Create a line with an icon, a [name], a input to change data and units.
  /// Units is optional
  InputWidget({Key key, @required Widget child, @required this.name, this.units})
    : super(
      key: key,
      children: [
        SizedBox(width: 10),
        Icon(Icons.ac_unit_sharp, color: Style.mainColor),
        SizedBox(width: 20),
        Text(name),
        SizedBox(width: 20),
        Expanded(child: child),
        units != null ? SizedBox(width: 20) : Container(),
        units != null ? Text(units) : Container(),
        SizedBox(width: 10),
      ]
  );
}

/// A [ToggleButtonCustom] class to define with a unique way for all [ToggleButton]
///
/// [children] contains all buttons. This class expends buttons in all line
class ToggleButtonCustom extends LayoutBuilder {
  /// Create a [ToggleButtonCustom] class to define with a unique way for all [ToggleButton]
  ///
  /// [children] contains all buttons. This class expends buttons in all line
  ToggleButtonCustom({Key key, @required List<Widget> children, @required isSelected, @required onPressed})
    :super(
      key: key,
      builder: (context, constraints){
        return ToggleButtons(
          constraints:
            BoxConstraints.expand(width: constraints.maxWidth / children.length - 2, height: 40),
          children: children,
          onPressed: onPressed,
          isSelected: isSelected
        );
      }
    );
}

/// Entry point of the widget [Calculator]
class Calculator extends StatefulWidget {
  const Calculator({Key key}) : super(key:key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

/// Defines state for [Calculator] class
class _CalculatorState extends State<Calculator>{
  /// Defines coefficient for bilirrubina from imperial to international value
  static double coeffBilirrubina = 17.104;
  /// Defines coefficient for albumina from imperial to international value
  static double coeffAlbumina = 10;
  /// Contains the output strings for okuda value
  ///
  /// This value is modified when "Calcular Okuda" button is pressed
  static String okuda = "";

  /// Defines units used between imperal and international
  static bool unidadesInternacionales = true;

  // The following values are automattcally update when user change value
  /// Contains international value of bilirrubina
  static double bilirrubina;
  /// Contains international value of albumina
  static double albumina;

  // This following List defines which button pressed in ToggleButtonCustom object
  // Only one item of each list can be on true on the same time
  /// List of button status for Ascitis input
  static List<bool> btnSelectAscitis = [true, false, false];
  /// List of button status for Tumor input
  static List<bool> btnSelectTumor = [true, false];
  /// List of button status for Unidades input
  static List<bool> btnSelectUnidades = [true, false];

  /// This function creates the list of items to display for this view
  ///
  /// There are 3 Items for flex Widgets.
  /// This enables to change view for landscape and portrait orientation.
  /// Items are inside [Column] Widget to display it each item under the previous one.
  /// [Column] is inside [Flexible] Widget to avoid error with undefined [InputWidget] size.
  ///
  /// The first item contains first part of view.
  /// There are users value : Bilirrubina, Albumina, Ascitis and Extension del tumor.
  ///
  /// The second item is a separator
  ///
  /// The last item are settings for application and output.
  /// Contains the choice for international unit and the output window
  List<Widget> _buildWidgetChildren(){
    return <Widget>[
      // First group of items
      Flexible(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Bilirrubina input
            InputWidget(
                name: "Bilirrubina",
                units: unidadesInternacionales ? "µmol/L" : "mg/dL",
                child: TextField(
                  // Display the number style keyboard rather than classic keyboard
                  keyboardType: TextInputType.number,
                  // InputFromatteurs defines authorized character inside TextField
                  // This is a number so only digits and dot are allowed
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))],
                  onChanged: (input) => setState ((){
                    //Check if input is not empty
                    if (input == null)
                      bilirrubina = null;
                    else {
                      bilirrubina = double.parse(input);
                      // Transform value in international unit
                      if (!unidadesInternacionales)
                        bilirrubina *= coeffBilirrubina;
                    }
                  })
                )
            ),
            // Albumina input
            InputWidget(
                name: "Albumina",
                units: unidadesInternacionales ? "g/L" : "g/dL",
                child: TextField(
                  // Display the number style keyboard rather than classic keyboard
                  keyboardType: TextInputType.number,
                  // InputFromatteurs defines authorized character inside TextField
                  // This is a number so only digits and dot are allowed
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))],
                  onChanged: (input) => setState (() {
                    //Check if input is not empty
                    if (input == null)
                      albumina = null;
                    else {
                      albumina = double.parse(input);
                      // Transform value in international unit
                      if (!unidadesInternacionales)
                        albumina *= coeffAlbumina;
                    }
                  }))
            ),
            // Ascitis input
            InputWidget(
                name: "Ascitis",
                child: ToggleButtonCustom(
                    children: <Widget> [
                      Text("Ninguna"),
                      Text("Controlada"),
                      Text("Refractario")
                    ],
                    onPressed: (int index) => setState((){
                      // Change the display to know the current pressed button
                      for (int i=0; i<btnSelectAscitis.length; i++)
                        btnSelectAscitis[i] = index == i;
                    }),
                    isSelected: btnSelectAscitis
                )),
            // Extension del tumor input
            InputWidget(
                name: "Extension del tumor %",
                child: ToggleButtonCustom(
                    children: <Widget> [
                      Text("<= 50%"),
                      Text("> 50%")
                    ],
                    onPressed: (int index) => setState((){
                      // Change the display to know the current pressed button
                      for (int i=0; i<btnSelectTumor.length; i++)
                        btnSelectTumor[i] = index == i;
                    }),
                    isSelected: btnSelectTumor
                )),
            // Button to calculate Okuda
            RaisedButton(
                child: Text("Calcular Okuda"),
                // When button is pressed, this function count the number of true value in pointsItems List
                // If the value if null, one input is not defined and display an error
                // Then, according source, defines output to display in result
                onPressed: () => setState(() {
                  // Display error message when Text input is empty
                  if (bilirrubina == null)
                    okuda = "Bilirrubina está vacía";
                  else if (albumina == null)
                    okuda = "Albumina está vacía";
                  else {
                    // Check all conditions and update okudaCount
                    int okudaCount = 0;
                    if (bilirrubina >= 51.0) okudaCount++;
                    if (albumina < 30.0) okudaCount++;
                    if (btnSelectAscitis[1] || btnSelectAscitis[2]) okudaCount++;
                    if (btnSelectTumor[1]) okudaCount++;

                    // Then update okuda according to official documentation and okudaCount
                    if (okudaCount == 0)
                      okuda = "I (0)";
                    else if (okudaCount <= 2)
                      okuda = "II ($okudaCount)";
                    else
                      okuda = "III ($okudaCount)";
                  }
                })
            ),
          ]
      )),
      // Create a gap between items
      Container(height: 75, width: 50),
      // Second group of items
      Flexible(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : <Widget> [
            // Unidades Internationales input
            InputWidget(
                name: "Unidades Internationales",
                child: ToggleButtonCustom(
                    children: <Widget> [
                      Text("ON"),
                      Text("OFF")
                    ],
                    onPressed: (int index) => setState((){
                      // Change the display to know the current pressed button
                      for (int i=0; i<btnSelectUnidades.length; i++)
                        btnSelectUnidades[i] = index == i;

                      // Check if the value of this button change
                      // If does, update value for Albumina, Bilirrubina and units used
                      if (unidadesInternacionales != btnSelectUnidades[0]){
                        unidadesInternacionales = btnSelectUnidades[0];
                        albumina = unidadesInternacionales ? albumina/coeffAlbumina : albumina*coeffAlbumina;
                        bilirrubina = unidadesInternacionales ? bilirrubina*coeffBilirrubina : bilirrubina/coeffBilirrubina;
                      }
                    }),
                    isSelected: btnSelectUnidades
                )),
            // Output box
            // Expended enables to take all available place for this item
            // Container enables to center element in the middle of space and creates border
            // Column contains output
            Expanded(child: Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Okuda:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(okuda, style: Style.textStyle)]),
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(border: Border.all())
            )),
          ]
      ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarStyle('Calculator'),
        // Body create margin thinks to Container to improve view
        // Flex enables to main axis to display items according orientation of application
        body: Container(
          margin: EdgeInsets.all(10),
          child: Flex(
            children: _buildWidgetChildren(),
            direction: MediaQuery.of(context).orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal
        )
    ));
  }
}