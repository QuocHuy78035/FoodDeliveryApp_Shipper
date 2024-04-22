import 'package:flutter/material.dart';

import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../../widgets/base_button.dart';
import '../views/merchant_auth/login_screen.dart';

class GoogleButton extends StatelessWidget {
  final void Function() onPressed;
  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      backgroundColor: ColorLib.whiteColor,
      borderColor: ColorLib.blackColor,
      onPressed: onPressed,
      titleRow:  const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.g_mobiledata,
            color: Colors.blue,
          ),
          Distance(
            width: GetSize.distance,
          ),
          Text(
            "Continue with Google",
            style: TextStyle(
              color: ColorLib.blackColor,
            ),
          )
        ],
      ),
    );
  }
}
