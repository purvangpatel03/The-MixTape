import 'package:flutter/material.dart';
import 'package:music_streaming_app/provider/audio_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/api_base_response.dart';
import '../../../theme/colors.dart';
import '../../../widgets/text_widget.dart';
import '../../track/track_screen.dart';

class AlbumListView extends StatelessWidget {
  final ApiBaseResponse provider;
  final int currentIndex;

  const AlbumListView(
      {super.key, required this.provider, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: ListTile(
              onTap: () async {
                Provider.of<AudioProvider>(context, listen: false).setData(provider, index);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TrackScreen(
                //       trackData: provider,
                //       currentIndex: index,
                //     ),
                //   ),
                // );
              },
              leading: Image(
                image: NetworkImage(
                  provider.data![index].album!.coverSmall!,
                ),
              ),
              title: TextWidget(
                text: provider.data![index].title!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ThemeColor.text,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              subtitle: TextWidget(
                text:
                    "${provider.data![index].title!} from ${provider.data![0].artist!.name!}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ThemeColor.textLight,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              trailing: const Icon(Icons.more_vert),
            ),
          );
        },
        childCount: provider.data?.length ?? 0,
      ),
    );
  }
}
