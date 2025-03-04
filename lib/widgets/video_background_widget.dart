import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  //const VideoBackground({super.key});

  @override
  // State<VideoBackground> createState() => _VideoBackgroundState();
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('assets/backgroundVideo.mp4')
      ..initialize().then((_) {
        // setState(() {});
        // _controller.setLooping(true);
        // _controller.play();
        if (mounted) {
          setState(() {}); // Ensure widget is still in the tree
          _controller!.setLooping(true);
          _controller!.play();
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : Container(
            color: Colors.green,
          );
  }
}
