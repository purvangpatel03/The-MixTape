import 'package:flutter/material.dart';
import 'package:music_streaming_app/theme/colors.dart';
import 'package:music_streaming_app/widgets/text_widget.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextWidget(
        text: 'Library Screen',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: ThemeColor.text,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
