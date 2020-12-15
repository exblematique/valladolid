import 'dart:convert' show jsonDecode;
import 'package:flutter/material.dart' show Alignment, AspectRatio, BuildContext, Center, CircularProgressIndicator, ConnectionState, Container, EdgeInsets, FloatingActionButton, FutureBuilder, Icon, Icons, Key, ListView, MaterialPageRoute, Navigator, RaisedButton, Scaffold, State, StatefulWidget, StatelessWidget, Text, Widget, required;
import 'package:video_player/video_player.dart' show VideoPlayer, VideoPlayerController;
import 'package:http/http.dart' as http show Response, get;
import 'package:valladolid_multiapp/style.dart';

/// A text Widget with a padding to improve design for listing of videos
class TextWithBorder extends Container {
  /// Creates a [text] with a padding to improve design for listing of videos
  TextWithBorder(String text, {key})
    : super(
      child: Text(
        text,
        key: key,
        style: Style.textStyle
      ),
    alignment: Alignment.center,
    padding: EdgeInsets.all(16)
  );
}

/// A [RaisedButton] to select one video to play
///
/// When the video is initialized, the method is different for network and resource videos.
class ToVideoButton extends RaisedButton {
  /// Path of the video either in folder /res/video or https website (http raise an error for insecure web page)
  final String controller;
  /// True when the video is store in web server. Else for videos in resource folder.
  final bool isNetworkVideo;

  /// Creates a [RaisedButton] to select one video to play.
  ToVideoButton({key, @required context, @required String name, @required this.controller, this.isNetworkVideo})
    : super (
      key: key,
      child: Text(name),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VideoPlayerScreen(
          controller,
          isNetworkVideo: isNetworkVideo,
        )
    )));
}

/// Defines a new view with all videos available for this application.
///
/// Videos can be in resource folder /res/ or on web server.
class Vodcast extends StatelessWidget {
  /// Contains a web server address
  ///
  /// It must be a folder which contains all videos.
  ///
  /// A php file with the same name of folder return a JSON object (list of strings) with all video names.
  /// Web server have the following tree:
  /// - videos.php
  /// - videos/
  ///   - video1.mp4
  ///   - video2.mp4
  String website = 'https://valladolid.alwaysdata.net/videos';

  /// This function download the JSON file which contains all videos name
  ///
  /// After downloading, this function return a [List<String>] which contain all video name on the server.
  Future<List> _retrieveVideoList() async {
    http.Response response = await http.get(website + '.php');
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarStyle('Vodcast'),
        body: FutureBuilder<List>(
        future: _retrieveVideoList(),
        builder: (context, snapshot) {
          List<Widget> output = new List<Widget>();
          output.add(TextWithBorder("Local videos"));
          output.add(ToVideoButton(
            context: context,
            name: "Video exemple",
            controller: 'res/videoEjemplo.mp4',
            isNetworkVideo: false
          ));
          output.add(TextWithBorder("-----------------------------"));
          output.add(TextWithBorder("Distant videos"));
          output.add(TextWithBorder("Los videos se pueden encontrar en " + website));

          if (snapshot.hasData) {
            for (int i=0; i<snapshot.data.length; i++)
              output.add(ToVideoButton(
                context: context,
                name: snapshot.data[i],
                controller: website + '/' + snapshot.data[i],
                isNetworkVideo: true
              ));
          }
          else if (snapshot.hasError)
            output.add(TextWithBorder('Ha habido un error : ${snapshot.error}'));
          else
            output.add(TextWithBorder("Lista de videos que se están descargando... Por favor, espere...."));
          return ListView(children: output);
      }));
  }
}





class VideoPlayerScreen extends StatefulWidget {
  final bool isNetworkVideo;
  final String videoPath;
  VideoPlayerScreen(this.videoPath, {Key key, this.isNetworkVideo}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  Future<void> _initializeVideoPlayerFuture;
  VideoPlayerController _controller;

  @override
  void initState() {

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = widget.isNetworkVideo ? VideoPlayerController.network(widget.videoPath) : VideoPlayerController.asset(widget.videoPath);
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    _controller.play();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle('Vodcast'),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: Center(child: VideoPlayer(_controller)),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}