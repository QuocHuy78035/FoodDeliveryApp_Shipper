import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/color_lib.dart';
import '../../../../utils/size_lib.dart';
import '../../../../widgets/base_button.dart';
import '../../widgets/title_screen.dart';
import 'login_screen.dart';

class VerifySignUpScreen extends StatefulWidget {
  final String pass;
  final String email;

  const VerifySignUpScreen({super.key, required this.email, required this.pass});

  @override
  State<VerifySignUpScreen> createState() => _VerifySignUpScreenState();
}

class _VerifySignUpScreenState extends State<VerifySignUpScreen> {
  final AuthController authController = AuthController();
  bool isLoading = false;
  bool _onEditing = true;
  late String _code;

  void confirmVerifyCode() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    if (_onEditing == true) {
      ShowSnackBar().showSnackBar(GlobalVariable.enterFullVerifyCode,
          ColorLib.primaryColor, ColorLib.whiteColor, context);
    } else {
      String message = await authController.verifySignUp(widget.email, _code, context);
      setState(() {
        isLoading = false;
      });
      if (message == GlobalVariable.verifySignUpSuc) {
        //firebase
        await authController.signUpWithEmailAndPass(widget.email, widget.pass, sharedPreferences.getString("userId") ?? "");

        ShowSnackBar().showSnackBar(
            message, Colors.green, ColorLib.whiteColor, context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen()
          ),
        );
      } else {
        ShowSnackBar().showSnackBar(
            message, ColorLib.primaryColor, ColorLib.whiteColor, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: GetSize.symmetricPadding * 2,
            ),
            child: Form(
              //key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const TitleScreen(title: "Verification Code"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Please enter the verification code that has been sent to ${widget.email}"),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: VerificationCode(
                      textStyle: const TextStyle(
                          fontSize: 21.0, color: ColorLib.primaryColor),
                      underlineColor: ColorLib.blackColor,
                      keyboardType: TextInputType.number,
                      length: 4,
                      onCompleted: (String value) {
                        setState(() {
                          _code = value;
                        });
                      },
                      onEditing: (bool value) {
                        setState(() {
                          _onEditing = value;
                        });
                        if (!_onEditing) FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  SizedBox(
                    height: GetSize.getHeight(context) * 0.1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: BaseButton(
                      onPressed: () async {
                        confirmVerifyCode();
                      },
                      titleRow: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                        "Confirm",
                        style: TextStyle(
                          color: ColorLib.whiteColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
