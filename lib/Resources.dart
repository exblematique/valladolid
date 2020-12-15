import 'dart:io' show Platform;
import 'package:flutter/material.dart' show BuildContext, Scaffold, State, StatefulWidget, Widget;
import 'package:webview_flutter/webview_flutter.dart' show SurfaceAndroidWebView, WebView;
import 'package:valladolid_multiapp/style.dart';

///
/// This file defines all action in Resources part for this application
///

/// Entry point for [VideoPlayerScreen] class
class Resources extends StatefulWidget {
  /// This is the link address of resources website
  final String website = 'https://valladolid.alwaysdata.net/';

  @override
  _ResourcesState createState() => _ResourcesState();
}

/// Defines state for [VideoPlayerScreen] class
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
      // Create a new view from url
      body: WebView(
        initialUrl: widget.website,
      )
    );
  }
}