import 'package:flutter/material.dart';

import '../../../models/api_base_response.dart';
import '../../../theme/colors.dart';
import '../../../widgets/text_widget.dart';

class AlbumAppBar extends StatelessWidget {
  final ApiBaseResponse provider;
  final int currentIndex;
  const AlbumAppBar({super.key, required this.currentIndex, required this.provider});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        var bottom = constraints.maxHeight;
        return FlexibleSpaceBar(
          title: AnimatedOpacity(
            opacity: bottom < 57 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: TextWidget(
              text: provider.data![currentIndex].artist!.name!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ThemeColor.text,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          background: Image(
            image: NetworkImage(
              provider.data![currentIndex].artist!.pictureMedium!,
            ),
          ),
        );
      }),
    );
  }
}
