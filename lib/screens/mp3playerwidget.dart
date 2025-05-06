import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class MP3PlayerWidget extends StatefulWidget {
  final String assetPath;

  const MP3PlayerWidget({Key? key, required this.assetPath}) : super(key: key);

  @override
  _MP3PlayerWidgetState createState() => _MP3PlayerWidgetState();
}

class _MP3PlayerWidgetState extends State<MP3PlayerWidget>
    with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    WidgetsBinding.instance.addObserver(this);
  }

  void _initializePlayer() {
    _audioPlayer = AudioPlayer();

    // Listen for duration and position changes
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // Handle song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _currentPosition = Duration.zero;
        _isPlaying = false;
      });
    });

    // Load the audio asset
    _audioPlayer.setSource(AssetSource(widget.assetPath));
  }

  @override
  void dispose() {
    _releaseAudioPlayer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _releaseAudioPlayer() async {
    await _audioPlayer.stop();
    await _audioPlayer.release();
    _audioPlayer.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _releaseAudioPlayer(); // Stop and release when the app is backgrounded
    } else if (state == AppLifecycleState.resumed) {
      _initializePlayer(); // Reinitialize when the app is foregrounded
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (_currentPosition == Duration.zero) {
        // If the song is at the beginning or has completed, play from the start
        await _audioPlayer.play(AssetSource(widget.assetPath));
      } else {
        // Resume playback if it was paused
        await _audioPlayer.resume();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade700, Colors.yellow.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Song Title Section
            Text(
              "Om Jai Jagdish",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),

            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.greenAccent,
                inactiveTrackColor: Colors.white.withOpacity(0.3),
                thumbColor: Colors.greenAccent,
                overlayColor: Colors.greenAccent.withOpacity(0.1),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                trackHeight: 2.0,
              ),
              child: Slider(
                value: _currentPosition.inSeconds.toDouble(),
                max: _totalDuration.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await _audioPlayer.seek(position);
                  setState(() {
                    _currentPosition = position;
                  });
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_currentPosition),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Text(
                  _formatDuration(_totalDuration),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: _togglePlayPause,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.greenAccent,
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
