import 'package:flutter/material.dart';
import 'package:music_streaming_app/widgets/show_dialog_box.dart';

import '../../../theme/colors.dart';
import '../../../widgets/text_widget.dart';

class HomeChipView extends StatelessWidget {
  const HomeChipView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            ShowDialog().showDialogBox(context);
          },
          child: Chip(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: ThemeColor.secondary,
            label: TextWidget(
              text: 'Music',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: ThemeColor.text,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8,),
        GestureDetector(
          onTap: (){
            ShowDialog().showDialogBox(context);
          },
          child: Chip(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: ThemeColor.secondary,
            label: TextWidget(
              text: 'Podcasts & Shows',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: ThemeColor.text,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8,),
        GestureDetector(
          onTap: (){
            ShowDialog().showDialogBox(context);
          },
          child: Chip(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: ThemeColor.secondary,
            label: TextWidget(
              text: 'Audiobooks',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: ThemeColor.text,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
