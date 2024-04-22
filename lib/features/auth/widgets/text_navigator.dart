import 'package:flutter/material.dart';

import '../../../utils/color_lib.dart';


class TextNavigator extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const TextNavigator(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(
              color: ColorLib.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}

