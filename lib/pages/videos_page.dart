import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Curated Videos'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoLibrary()),
                );
              },
              child: Text('Watch Videos'),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoLibrary extends StatefulWidget {
  @override
  _VideoLibraryState createState() => _VideoLibraryState();
}

class _VideoLibraryState extends State<VideoLibrary> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;
  List<String> videoUrls = [
    'https://pixabay.com/videos/download/video-140111_tiny.mp4',
    'https://pixabay.com/videos/download/video-47213_small.mp4',
    'https://v3.cdnpk.net/videvo_files/video/free/2022-01/large_preview/220114_01_Drone_4k_017.mp4?token=exp=1722252947~hmac=9203d516209373deb36a8dbb642c9d91a32098885aa0e7c48d301da236fbd0af',
  ];
  String? selectedVideo;
  bool isError = false;

  void _initializeVideoController(String url) {
    setState(() {
      isError = false;
    });
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _controller!,
            autoPlay: true,
            looping: false,
            aspectRatio: _controller!.value.aspectRatio,
            autoInitialize: true,
          );
        });
      }).catchError((error) {
        setState(() {
          isError = true;
        });
      });
  }

  void _onVideoSelected(String url) {
    setState(() {
      selectedVideo = url;
      if (_controller != null) {
        _controller!.dispose();
      }
      if (_chewieController != null) {
        _chewieController!.dispose();
      }
      _initializeVideoController(selectedVideo!);
    });
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Library'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Video ${index + 1}'),
                  onTap: () => _onVideoSelected(videoUrls[index]),
                );
              },
            ),
          ),
          if (selectedVideo != null)
            Expanded(
              child: _controller != null && _controller!.value.isInitialized
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Chewie(
                            controller: _chewieController!,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedVideo = null;
                              _controller!.dispose();
                              _chewieController!.dispose();
                              _controller = null;
                              _chewieController = null;
                            });
                          },
                          child: Text('Back to Video List'),
                        ),
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VideosPage(),
  ));
}
