import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valladolid_multiapp/style.dart';

class InputWidget extends Wrap {
  String name;

  InputWidget({Key key, Widget child, this.name})
    : super(
      key: key,
      children: [
        SizedBox(width: 20),
        Icon(Icons.ac_unit_sharp, color: Style.mainColor),
        SizedBox(width: 20),
        Text(name),
        SizedBox(width: 20),
        Expanded(child: child)
      ]
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
  static String okuda = "";
  static List<bool> pointsItems = [true, false, false, false];
  static List<bool> ascitis = [true, false, false];
  static List<bool> tumor = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarStyle('Calculator'),
        body: GridView.count(
          //Adapt view for portrait and landscape orientation
          crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 2,
          children: <Widget>[
            Column(
              children: <Widget>[
                InputWidget(
                  name: "Bilirrubina",
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))],
                    onChanged: (input) => pointsItems[0] = double.parse(input) >= 51.0
                  )
                ),
                InputWidget(
                  name: "Albumina",
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))],
                    onChanged: (input) => pointsItems[1] = double.parse(input) < 30.0
                  )
                ),
                InputWidget(
                  name: "Ascitis",
                  child: ToggleButtons(
                    children: <Widget> [
                      Text("Ninguna"),
                      Text("Controlada"),
                      Text("Refractario")
                    ],
                    onPressed: (int index) => setState((){
                      // Change the display to know the current pressed button
                      for (int i=0; i<ascitis.length; i++)
                      ascitis[i] = index == i;
                      // Define pointsItems with true when "Ninguna" is not selected
                      pointsItems[2] = !ascitis[0];
                    }),
                    isSelected: ascitis
                )),
                InputWidget(
                  name: "Extension del tumor %",
                  child: ToggleButtons(
                    children: <Widget> [
                     Text("<= 50%"),
                     Text("> 50%")
                    ],
                    onPressed: (int index) => setState((){
                      // Change the display to know the current pressed button
                      for (int i=0; i<tumor.length; i++)
                        tumor[i] = index == i;
                      // Define pointsItems with true when ">50%" is selected
                      pointsItems[3] = tumor[1];
                    }),
                    isSelected: tumor
                )),
                RaisedButton(
                  child: Text("Calcular Okuda"),
                  onPressed: () => setState(() {
                    int okudaCount = 0;
                    for (int i=0; i<pointsItems.length; i++)
                      okudaCount += pointsItems[i] ? 1 : 0;
                    if (okudaCount == 0)
                      okuda = "I (0)";
                    else if (okudaCount < 3)
                      okuda = "II ($okudaCount)";
                    else
                      okuda = "III ($okudaCount)";
                  })),
                Row(children: [Text("Okuda "),Text(okuda)])
              ]
            ),

        ]
    ));
  }
}