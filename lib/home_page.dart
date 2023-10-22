import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:video_player/video_player.dart';

import 'music_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Media Kit Video Player"),
        ),
        body: GridView.builder(
          itemCount: videos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerPage(
                        videoUrl: videos[index]["url"],
                        subtitleUrl: videos[index]["subtitle"],
                        musicTitle: videos[index]["title"]),
                  ));
            },
            child: ImageBox(index: index),
          ),
        ));
  }
}

class ImageBox extends StatelessWidget {
   ImageBox({
    super.key,
    required this.index
  });
  int index;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        
        ///Image
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExtendedImage.network(
            videos[index]["image"],
            fit: BoxFit.cover,
            height: mq.height*0.2,
            width: mq.width/2,
            cache: true,
            border: Border.all(color: Colors.white),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            //cancelToken: cancellationToken,
          ),
        ),
        
        ///Music Title
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(videos[index]["title"],overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white70, fontSize: 12),),
          ),
        )
      ],
    );
  }
}
