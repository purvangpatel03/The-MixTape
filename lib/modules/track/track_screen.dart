import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_streaming_app/models/api_base_response.dart';
import 'package:music_streaming_app/models/audio.dart';
import 'package:music_streaming_app/provider/audio_provider.dart';
import 'package:music_streaming_app/theme/colors.dart';
import 'package:music_streaming_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class TrackScreen extends StatefulWidget {
  final ApiBaseResponse trackData;
  int currentIndex;

  TrackScreen({super.key, required this.trackData, required this.currentIndex});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    getPlaylistData();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future getPlaylistData() async {
    final playlist = ConcatenatingAudioSource(
      children: List.generate(
        widget.trackData.data!.length,
        (index) {
          return AudioSource.uri(
            Uri.parse(widget.trackData.data![index].preview!),
          );
        },
      ),
    );
    await player.setAudioSource(
      initialIndex: widget.currentIndex,
      initialPosition: Duration.zero,
      playlist,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: widget.trackData.data![widget.currentIndex].album!.title!,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ThemeColor.text,
                fontWeight: FontWeight.w700,
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.trackData.data![widget.currentIndex].album!.coverBig!,
                width: 320,
                height: 320,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            TextWidget(
              text: widget.trackData.data![widget.currentIndex].title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ThemeColor.text,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: StreamBuilder(
                  stream: player.positionStream,
                  builder: (context, snapshot) {
                    return ProgressBar(
                      timeLabelTextStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ThemeColor.text,
                              ),
                      barCapShape: BarCapShape.round,
                      baseBarColor: ThemeColor.textLight.withOpacity(0.3),
                      progressBarColor: ThemeColor.textGreen,
                      barHeight: 4,
                      thumbRadius: 6,
                      thumbColor: ThemeColor.white,
                      progress: player.position,
                      total: player.playbackEvent.duration ??
                          const Duration(seconds: 30),
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 40,
                  color: ThemeColor.white,
                  onPressed: () {
                    if (widget.currentIndex > 0) {
                      setState(() {
                        widget.currentIndex--;
                      });
                      player.seekToPrevious();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.fast_rewind),
                  iconSize: 40,
                  color: ThemeColor.white,
                  onPressed: () {
                    if (player.position > const Duration(seconds: 5)) {
                      player.seek(player.position - const Duration(seconds: 5));
                    } else {
                      player.seek(player.position - player.position);
                    }
                  },
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColor.white,
                  ),
                  child: IconButton(
                      icon: player.playing
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow),
                      iconSize: 30,
                      onPressed: () async {
                        player.currentIndexStream.listen((event) {
                          setState(() {
                            widget.currentIndex = event ?? 0;
                          });
                        });
                        if (player.playing) {
                          player.pause();
                        } else {
                          await player.play();
                        }
                      }),
                ),
                const SizedBox(
                  width: 12,
                ),
                IconButton(
                  icon: const Icon(Icons.fast_forward),
                  iconSize: 40,
                  color: ThemeColor.white,
                  onPressed: () {
                    player.seek(player.position + const Duration(seconds: 5));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 40,
                  color: ThemeColor.white,
                  onPressed: () {
                    if (widget.currentIndex <
                        widget.trackData.data!.length - 1) {
                      setState(() {
                        widget.currentIndex++;
                      });
                      player.seekToNext();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
