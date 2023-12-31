// ignore_for_file: non_constant_identifier_names

import 'package:facebook/Screens/constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class VideoFeed extends StatefulWidget {
  const VideoFeed({
    super.key,
    required this.profileUrl,
    required this.username,
    required this.posttime,
    required this.caption,
    required this.photoUrl,
    // add video
    this.isVideo = false,
    this.controller, // can't required
  });
  // can throw insert
  final String profileUrl;
  final String username;
  final String posttime;
  final String caption;
  final String photoUrl;
  // add video
  final bool isVideo;
  final VideoPlayerController? controller;
  @override
  State<VideoFeed> createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  // null labl
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  backgroundImage: AssetImage(
                    widget.profileUrl,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // add photo post like or commit share
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.username,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Text((widget.posttime)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.public,
                          size: 25,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              // icon more_horiz delete, editing
              IconButton(
                  onPressed: () {
                    debugPrint("New feed");
                  },
                  icon: const Icon(Icons.more_horiz)),
            ],
          ),
        ),
        // add post
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.caption),
        ),
        const SizedBox(
          height: 10,
        ),
        // put photo or video in post
        widget.isVideo == false
            ? GestureDetector(
                // check video
                // can view_photo
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          // close photo
                          Stack(
                        children: [
                          PhotoView(
                            imageProvider: AssetImage(widget.photoUrl),
                          ),
                          SafeArea(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  widget.photoUrl,
                  fit: BoxFit.cover,
                  //    height: 250,
                  width: double.infinity,
                ),
              )
            : widget.controller!.value.isInitialized // // show video
                ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: widget.controller!.value.aspectRatio,
                        child: VideoPlayer(widget.controller!),
                      ),
                      // Click video
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              widget.controller!.value.isPlaying
                                  ? widget.controller!.pause()
                                  : widget.controller!.play();
                              setState(() {});
                            },
                            icon: widget.controller!.value.isPlaying
                                ? const Icon(
                                    Icons.pause,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    // check video
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.4),
                    child: const Center(
                      child: Icon(Icons.play_arrow),
                    ),
                  ),
        // input emoji
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: const [
              Text(
                '👍',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '❤️',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '😅',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '100 others',
                style: TextStyle(color: KeyTextColor),
              ),
              // throw spacer
              Spacer(),
              Text(
                "17 comments",
                style: TextStyle(color: KeyTextColor),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(Icons.thumb_up_alt_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text("like"),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(Icons.comment_sharp),
                    SizedBox(
                      width: 10,
                    ),
                    Text("comment"),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(Icons.share_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("share"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
