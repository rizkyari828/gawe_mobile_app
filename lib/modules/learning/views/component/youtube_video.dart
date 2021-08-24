import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class youtubePlayer extends StatefulWidget {
  String link;

  youtubePlayer({this.link});
  @override
  _youtubePlayerState createState() => _youtubePlayerState();
}

class _youtubePlayerState extends State<youtubePlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.link,
        flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
    ));
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      // child: Text('d'),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        liveUIColor: Colors.amber,
      ),
    );
  }
}