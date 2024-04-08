import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_streaming_app/modules/main/main_screen.dart';
import 'package:music_streaming_app/notification/music_notification.dart';
import 'package:music_streaming_app/provider/audio_provider.dart';
import 'package:music_streaming_app/provider/home_provider.dart';
import 'package:music_streaming_app/theme/my_theme.dart';
import 'package:music_streaming_app/widgets/my_mini_player.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MusicNotification().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        title: 'Music Streaming App',
        home: const MainScreen(),
        builder: (context, child){
          return Stack(
            children: [
              child!,
              Consumer<AudioProvider>(
                builder: (context, value, child) {
                  return Visibility(
                    visible: value.shouldMiniPlayerBeVisible,
                    child: MyMiniPlayer(
                      currentIndex: value.currentIndex,
                      trackData: value.miniPlayerApi,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}