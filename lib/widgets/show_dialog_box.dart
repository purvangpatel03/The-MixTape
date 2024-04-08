import 'package:flutter/material.dart';
import 'package:music_streaming_app/widgets/text_widget.dart';

import '../theme/colors.dart';

class ShowDialog {
  Future showDialogBox(BuildContext context) async {
    showDialog(
      barrierDismissible: true,
      context: (context),
      builder: (context) {
        return AlertDialog(
          backgroundColor: ThemeColor.primary,
          title: Center(
            child: TextWidget(
              text: "Hello Sir",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ThemeColor.textGreen,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        );
      },
    );
  }
}
