import 'package:flutter/material.dart';
import 'package:music_streaming_app/models/api_base_response.dart';
import 'package:music_streaming_app/modules/album/album_screen.dart';
import 'package:music_streaming_app/modules/home/widgets/home_chip_view.dart';
import 'package:music_streaming_app/provider/home_provider.dart';
import 'package:music_streaming_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController artistController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getArtistData();
  }

  @override
  void dispose() {
    super.dispose();
    artistController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HomeChipView(),
          const SizedBox(
            height: 8,
          ),
          Consumer<HomeProvider>(
            builder: (context, provider, child) {
              if (provider.artist.isEmpty) {
                return Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: const Color.fromRGBO(44, 44, 44, 1.0),
                        highlightColor: const Color.fromRGBO(44, 44, 44, 0.5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeColor.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: provider.artist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumScreen(
                                provider: provider.artist[index],
                                currentIndex: index,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeColor.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                                child: Image(
                                  //fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                    provider.artist[index].data![index].artist!
                                        .picture!,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TextWidget(
                                  maxLines: 2,
                                  text: provider
                                      .artist[index].data![index].artist!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: ThemeColor.text,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: artistController,
            onSubmitted: (name) async {
              final myProvider =
                  Provider.of<HomeProvider>(context, listen: false);
              await myProvider.getOtherArtistData(name);
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlbumScreen(
                      provider: myProvider.artist[0],
                      currentIndex: 0,
                    ),
                  ),
                );
              }
              artistController.clear();
            },
            cursorColor: ThemeColor.textGreen,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ThemeColor.text, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: 'Want to Listen from other artist??',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeColor.text,
                    fontWeight: FontWeight.w500,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: ThemeColor.textGreen,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: ThemeColor.textGreen,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FilledButton(
            onPressed: () async {
              String name = artistController.text.trim();
              print(name);
              if(name.isNotEmpty && name != ''){
                final myProvider =
                Provider.of<HomeProvider>(context, listen: false);
                await myProvider.getOtherArtistData(name);
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumScreen(
                        provider: myProvider.artist[0],
                        currentIndex: 0,
                      ),
                    ),
                  );
                }
                artistController.clear();
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: ThemeColor.textGreen,
              foregroundColor: ThemeColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: TextWidget(
              text: 'Listen',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeColor.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
