import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage(
      {Key? key,
      required this.videoUrl,
      required this.subtitleUrl,
      required this.musicTitle})
      : super(key: key);

  String videoUrl;
  String subtitleUrl;

  String musicTitle;

  @override
  State<VideoPlayerPage> createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  // Create a [Player] to control playback.
  late final player = Player();

  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(
    player,
  );

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media(
      widget.videoUrl,
    ));
    player.setSubtitleTrack(
        SubtitleTrack.uri(widget.subtitleUrl, title: "English"));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white70),
        title: Text(
          widget.musicTitle,
          style: const TextStyle(color: Colors.white54, fontSize: 20),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: mq.width,
          height: mq.height * 0.85,
          child: Video(
              controller: controller,
              subtitleViewConfiguration: SubtitleViewConfiguration(
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                  visible: true)),
        ),
      ),
    );
  }
}
