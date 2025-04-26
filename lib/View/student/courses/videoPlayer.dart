import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:async';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  const VideoPlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isVideoPlaying = false;
  double _currentVideoPosition = 0;
  double _videoDuration = 0;
  Timer? _positionTimer;
  String _currentQuality = 'auto';
  final List<String> _qualities = ['auto', '144p', '240p', '360p', '480p', '720p', '1080p'];
  bool _showQualityMenu = false;
  bool _showControls = true;
  
  // Define skip duration in seconds
  final int _skipDuration = 10;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayerController.convertUrlToId(widget.url);

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId ?? '',
      params: const YoutubePlayerParams(
        showControls: false,
        showFullscreenButton: true,
        mute: false,
        loop: false,
        enableJavaScript: true,
        playsInline: true,
        strictRelatedVideos: true,
        pointerEvents: PointerEvents.none,
      ),
    );

    _controller.listen((event) {
      if (event.playerState == PlayerState.playing) {
        setState(() {
          _isVideoPlaying = true;
        });
        _startPositionTimer();
      } else if (event.playerState == PlayerState.paused) {
        setState(() {
          _isVideoPlaying = false;
        });
      }
    });

    _initializeVideo();
    
    // Auto-hide controls after a delay
    _resetControlsTimer();
  }

  Future<void> _initializeVideo() async {
    _controller.listen((event) async {
      if (event.playerState == PlayerState.playing) {
        final duration = await _controller.duration;
        final quality = await _controller.videoQuality;
        setState(() {
          _videoDuration = duration.toDouble();
          if (quality != null) {
            _currentQuality = quality;
          }
        });
      }
    });
  }

  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      if (mounted) {
        final position = await _controller.currentTime;
        setState(() {
          _currentVideoPosition = position.toDouble();
        });
      }
    });
  }

  Timer? _controlsTimer;
  
  void _resetControlsTimer() {
    _controlsTimer?.cancel();
    setState(() {
      _showControls = true;
    });
    
    // Auto-hide controls after 3 seconds of inactivity
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _isVideoPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  Future<void> _changeQuality(String quality) async {
    try {
      await _controller.setPlaybackQuality(quality);
      setState(() {
        _currentQuality = quality;
        _showQualityMenu = false;
      });
    } catch (e) {
      print('Error changing quality: $e');
    }
  }

  String _formatDuration(double seconds) {
    final Duration duration = Duration(seconds: seconds.round());
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds - minutes * 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> _toggleVideoPlayback() async {
    try {
      if (_isVideoPlaying) {
        await _controller.pauseVideo();
        _positionTimer?.cancel();
      } else {
        await _controller.playVideo();
        _startPositionTimer();
      }
      setState(() {
        _isVideoPlaying = !_isVideoPlaying;
      });
      _resetControlsTimer();
    } catch (e) {
      print('Error toggling playback: $e');
    }
  }

  Future<void> _skipForward() async {
    try {
      double newPosition = _currentVideoPosition + _skipDuration;
      if (newPosition > _videoDuration) {
        newPosition = _videoDuration;
      }
      
      await _controller.seekTo(
        seconds: newPosition,
        allowSeekAhead: true,
      );
      
      setState(() {
        _currentVideoPosition = newPosition;
      });
      _resetControlsTimer();
    } catch (e) {
      print('Error skipping forward: $e');
    }
  }

  Future<void> _skipBackward() async {
    try {
      double newPosition = _currentVideoPosition - _skipDuration;
      if (newPosition < 0) {
        newPosition = 0;
      }
      
      await _controller.seekTo(
        seconds: newPosition,
        allowSeekAhead: true,
      );
      
      setState(() {
        _currentVideoPosition = newPosition;
      });
      _resetControlsTimer();
    } catch (e) {
      print('Error skipping backward: $e');
    }
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    _controlsTimer?.cancel();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final videoHeight = screenSize.height * 0.75;
    final videoWidth = screenSize.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey[100],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () {
            _controller.close();
            Navigator.pop(context);
          },
        ),
        title: const Text(''),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
          if (_showControls) {
            _resetControlsTimer();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video player
            Container(
              color: Colors.black,
              child: Center(
                child: SizedBox(
                  width: videoWidth,
                  height: videoHeight,
                  child: YoutubePlayer(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  ),
                ),
              ),
            ),
            
            // Video controls overlay
            if (_showControls)
              AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: videoWidth,
                  height: videoHeight,
                  color: Colors.black26,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top gradient for better visibility
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black54, Colors.transparent],
                          ),
                        ),
                      ),
                      
                      // Center play/pause button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.replay_10,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: _skipBackward,
                          ),
                          const SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(12),
                            child: IconButton(
                              icon: Icon(
                                _isVideoPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 42,
                              ),
                              onPressed: _toggleVideoPlayback,
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: Icon(
                              Icons.forward_10,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: _skipForward,
                          ),
                        ],
                      ),
                      
                      // Bottom controls bar with gradient background
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black87, Colors.transparent],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Progress bar
                            Row(
                              children: [
                                Text(
                                  _formatDuration(_currentVideoPosition),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      thumbColor: Colors.red,
                                      activeTrackColor: Colors.red,
                                      inactiveTrackColor: Colors.white30,
                                      trackHeight: 3.0,
                                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                                    ),
                                    child: Slider(
                                      value: _currentVideoPosition.clamp(0.0, _videoDuration),
                                      min: 0.0,
                                      max: _videoDuration,
                                      onChanged: (value) async {
                                        setState(() {
                                          _currentVideoPosition = value;
                                        });
                                        await _controller.seekTo(
                                          seconds: value,
                                          allowSeekAhead: true,
                                        );
                                        _resetControlsTimer();
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  _formatDuration(_videoDuration),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Bottom row with additional controls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Quality selector button
                                PopupMenuButton<String>(
                                  initialValue: _currentQuality,
                                  onSelected: _changeQuality,
                                  itemBuilder: (context) => _qualities.map((quality) {
                                    return PopupMenuItem<String>(
                                      value: quality,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(quality),
                                          if (quality == _currentQuality)
                                            const Icon(Icons.check, size: 18, color: Colors.blue),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  position: PopupMenuPosition.over,
                                  offset: const Offset(0, -120),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.settings, color: Colors.white, size: 18),
                                        const SizedBox(width: 4),
                                        Text(
                                          _currentQuality,
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            // Loading indicator (when video is buffering)
            if (!_isVideoPlaying && _currentVideoPosition == 0)
              const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

extension on YoutubePlayerController {
  get videoQuality => null;

  setPlaybackQuality(String quality) {}
}