import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_streaming_app/models/api_base_response.dart';
import 'package:music_streaming_app/modules/album/widgets/albul_list_view.dart';
import 'package:music_streaming_app/modules/album/widgets/album_app_bar.dart';
import 'package:music_streaming_app/provider/audio_provider.dart';
import 'package:music_streaming_app/widgets/my_mini_player.dart';
import 'package:provider/provider.dart';

import '../../theme/colors.dart';
import '../../widgets/text_widget.dart';

class AlbumScreen extends StatefulWidget {
  final ApiBaseResponse provider;
  final int currentIndex;

  const AlbumScreen(
      {super.key, required this.provider, required this.currentIndex});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                AlbumAppBar(
                    currentIndex: widget.currentIndex,
                    provider: widget.provider),
                AlbumListView(
                    provider: widget.provider,
                    currentIndex: widget.currentIndex),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
