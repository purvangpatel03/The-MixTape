import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_streaming_app/modules/home/home_screen.dart';
import 'package:music_streaming_app/modules/main/widgets/main_app_bar.dart';
import 'package:music_streaming_app/modules/main/widgets/main_bottom_bar.dart';
import 'package:music_streaming_app/modules/library/library_screen.dart';
import 'package:music_streaming_app/modules/search/search_screen.dart';
import 'package:music_streaming_app/provider/audio_provider.dart';
import 'package:music_streaming_app/theme/colors.dart';
import 'package:music_streaming_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: MainBottomBar(
        onChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: Stack(
        children: [
          getBody(),
          // Consumer<AudioProvider>(builder: (context, provider, child) {
          //   return Visibility(
          //     visible: true,
          //     child: Miniplayer(
          //         minHeight: 70,
          //         maxHeight: 70,
          //         builder: (height, percentage) {
          //           return Container(
          //             color: ThemeColor.secondary,
          //             child: Row(
          //               children: [
          //                 ClipRRect(
          //                   borderRadius: const BorderRadius.only(
          //                     topLeft: Radius.circular(12),
          //                     bottomLeft: Radius.circular(12),
          //                   ),
          //                   child: Image(
          //                     height: 70,
          //                     width: 70,
          //                     image: NetworkImage(
          //                       provider.currentAudio?.songImage ??
          //                           'https://e-cdns-images.dzcdn.net/images/artist/19cc38f9d69b352f718782e7a22f9c32/56x56-000000-80-0-0.jpg',
          //                     ),
          //                   ),
          //                 ),
          //                 const SizedBox(
          //                   width: 8,
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     const SizedBox(
          //                       height: 8,
          //                     ),
          //                     TextWidget(
          //                       text: provider.currentAudio?.songTitle ?? '',
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodyLarge
          //                           ?.copyWith(
          //                             color: ThemeColor.text,
          //                             fontWeight: FontWeight.w600,
          //                           ),
          //                     ),
          //                     const SizedBox(
          //                       height: 4,
          //                     ),
          //                     TextWidget(
          //                       text: provider.currentAudio?.albumTitle ?? '',
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodyMedium
          //                           ?.copyWith(
          //                             color: ThemeColor.textGreen,
          //                             fontWeight: FontWeight.w500,
          //                           ),
          //                     ),
          //                   ],
          //                 ),
          //                 IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(Icons.play_arrow),
          //                 ),
          //               ],
          //             ),
          //           );
          //         }),
          //   );
          // }),
        ],
      ),
    );
  }

  getBody() {
    switch (currentIndex) {
      case 1:
        return const SearchScreen();
      case 2:
        return const PlaylistScreen();
      default:
        return const HomeScreen();
    }
  }
}
