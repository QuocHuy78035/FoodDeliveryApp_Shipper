import 'package:flutter/material.dart';

class UserTitle extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  const UserTitle({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Icon(Icons.person),
            Text(text ?? "")
          ],
        ),
      ),
    );
  }
}
