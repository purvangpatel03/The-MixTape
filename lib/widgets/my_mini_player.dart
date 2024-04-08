import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_streaming_app/notification/music_notification.dart';
import 'package:music_streaming_app/widgets/text_widget.dart';

import '../models/api_base_response.dart';
import '../theme/colors.dart';

class MyMiniPlayer extends StatefulWidget {
  final ApiBaseResponse trackData;
  int? currentIndex;

  MyMiniPlayer({
    super.key,
    required this.currentIndex,
    required this.trackData,
  });

  @override
  State<MyMiniPlayer> createState() => _MyMiniPlayerState();
}

class _MyMiniPlayerState extends State<MyMiniPlayer> {
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    getPlaylistData();
  }

  @override
  void didUpdateWidget(covariant MyMiniPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    getPlaylistData();
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
    MusicNotification().showNotificationAndroid(
      widget.trackData.data![widget.currentIndex!].title!,
      widget.trackData.data![widget.currentIndex ?? 0].album!.title!,
    );
    return Miniplayer(
      minHeight: 70,
      maxHeight: MediaQuery.sizeOf(context).height,
      backgroundColor: ThemeColor.secondary,
      curve: Curves.easeOut,
      builder: (height, percentage) {
        if (height > 120) {
          return Container(
            height: height,
            color: ThemeColor.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.trackData.data![widget.currentIndex!].album!
                          .coverBig!,
                      width: height / 2.5,
                      height: height / 2.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Visibility(
                    visible: height > MediaQuery.sizeOf(context).height / 2
                        ? true
                        : false,
                    child: const SizedBox(height: 32),
                  ),
                  TextWidget(
                    text: widget.trackData.data![widget.currentIndex!].title!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Visibility(
                    visible: height > MediaQuery.sizeOf(context).height / 2
                        ? true
                        : false,
                    child: const SizedBox(height: 16),
                  ),
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
                      },
                    ),
                  ),
                  Visibility(
                    visible: height > MediaQuery.sizeOf(context).height / 2
                        ? true
                        : false,
                    child: const SizedBox(height: 16),
                  ),
                  Visibility(
                    visible: height > MediaQuery.sizeOf(context).height / 3.8
                        ? true
                        : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          iconSize: 40,
                          color: ThemeColor.white,
                          onPressed: () {
                            if (widget.currentIndex! > 0) {
                              setState(() {
                                player.seekToPrevious();
                                widget.currentIndex = widget.currentIndex! - 1;
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.fast_rewind),
                          iconSize: 40,
                          color: ThemeColor.white,
                          onPressed: () {
                            if (player.position > const Duration(seconds: 5)) {
                              player.seek(
                                  player.position - const Duration(seconds: 5));
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
                            player.seek(
                                player.position + const Duration(seconds: 5));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          iconSize: 40,
                          color: ThemeColor.white,
                          onPressed: () {
                            if (widget.currentIndex! <
                                widget.trackData.data!.length - 1) {
                              setState(() {
                                player.seekToNext();
                                widget.currentIndex = widget.currentIndex! + 1;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          );
        } else {
          return Container(
            color: ThemeColor.secondary,
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image(
                        height: 66,
                        width: 66,
                        image: NetworkImage(
                          widget.trackData.data?[widget.currentIndex ?? 0].album
                                  ?.coverBig ??
                              'https://e-cdns-images.dzcdn.net/images/artist/19cc38f9d69b352f718782e7a22f9c32/56x56-000000-80-0-0.jpg',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          TextWidget(
                            text: widget.trackData
                                    .data?[widget.currentIndex ?? 0].title ??
                                '',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ThemeColor.text,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          TextWidget(
                            text: widget
                                    .trackData
                                    .data?[widget.currentIndex ?? 0]
                                    .album
                                    ?.title ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ThemeColor.textGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        player.seekToNext();
                        setState(() {
                          widget.currentIndex = widget.currentIndex! + 1;
                        });
                      },
                      icon: Icon(
                        color: ThemeColor.white,
                        Icons.skip_previous,
                      ),
                    ),
                    IconButton(
                        icon: player.playing
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                        iconSize: 30,
                        color: ThemeColor.white,
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
                    IconButton(
                      onPressed: () async {
                        player.seekToNext();
                        setState(() {
                          widget.currentIndex = widget.currentIndex! + 1;
                        });
                      },
                      icon: Icon(
                        color: ThemeColor.white,
                        Icons.skip_next,
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: player.positionStream,
                  builder: (context, snapshot) {
                    return ProgressBar(
                      timeLabelTextStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ThemeColor.text,
                              ),
                      baseBarColor: ThemeColor.textLight.withOpacity(0.3),
                      progressBarColor: ThemeColor.textGreen,
                      barHeight: 4,
                      thumbRadius: 2,
                      thumbGlowRadius: 2,
                      thumbColor: ThemeColor.white,
                      timeLabelLocation: TimeLabelLocation.none,
                      progress: player.position,
                      total: player.playbackEvent.duration ??
                          const Duration(seconds: 30),
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
