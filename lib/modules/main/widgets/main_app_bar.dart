import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_streaming_app/theme/colors.dart';
import 'package:music_streaming_app/widgets/text_widget.dart';

import '../../../widgets/show_dialog_box.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: 'Good Afternoon',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ThemeColor.text,
              fontWeight: FontWeight.w500,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            ShowDialog().showDialogBox(context);
          },
          color: ThemeColor.white,
          icon: const Icon(CupertinoIcons.bell),
        ),
        IconButton(
          onPressed: () {
            ShowDialog().showDialogBox(context);
          },
          color: ThemeColor.white,
          icon: const Icon(CupertinoIcons.clock),
        ),
        IconButton(
          onPressed: () {
            ShowDialog().showDialogBox(context);
          },
          color: ThemeColor.white,
          icon: const Icon(Icons.settings_sharp),
        ),
      ],
    );
  }
}
