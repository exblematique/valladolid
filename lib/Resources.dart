import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:valladolid_multiapp/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Resources extends StatefulWidget {
  final String website = 'https://valladolid.alwaysdata.net/';

  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources>{
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarStyle('Resources'),
      body: WebView(
        initialUrl: widget.website,
      )
    );
  }
}