import 'package:flutter/material.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:video_player/video_player.dart';

class VideoP extends StatefulWidget {
  String link;

  VideoP({this.link});

  @override
  _VideoPState createState() => _VideoPState(link: link);
}

class _VideoPState extends State<VideoP> {
  String link;

  _VideoPState({this.link});

  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    checkUpdate();
  }

  checkUpdate() async {
    setState(() {
      _controller = VideoPlayerController.network(
        '${widget.link}',
        // closedCaptionFile: _loadCaptions(),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      _controller.addListener(() {
        setState(() {});
      });
      _controller.setLooping(true);
      _controller.initialize();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Text('${widget.link}'),
          Container(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  ClosedCaption(text: _controller.value.caption.text),
                  // _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Icon(Icons.school),
                Icon(
                  _controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              ],
            ),
            color: mainColor,
            textColor: Colors.white,
            elevation: 5,
          ),
        ],
      ),
    );
  }
}
