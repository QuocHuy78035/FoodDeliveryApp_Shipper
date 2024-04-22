import 'package:flutter/material.dart';

class TitleScreen extends StatelessWidget {
  final String title;
  const TitleScreen({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}