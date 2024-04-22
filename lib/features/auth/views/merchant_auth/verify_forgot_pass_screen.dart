import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/features/auth/views/merchant_auth/reset_pass_screen.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import '../../../../utils/color_lib.dart';
import '../../../../utils/size_lib.dart';
import '../../../../widgets/base_button.dart';
import '../../widgets/title_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String email;

  const VerifyScreen({super.key, required this.email});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final AuthController authController = AuthController();
  bool isLoading = false;
  bool _onEditing = true;
  late String _code;

  void confirmVerifyCode() async {
    setState(() {
      isLoading = true;
    });
    if (_onEditing == true) {
      ShowSnackBar().showSnackBar(GlobalVariable.enterFullVerifyCode,
          ColorLib.primaryColor, ColorLib.whiteColor, context);
    } else {
      List<String> message = await authController.verifyForgotPass(widget.email, _code);
      setState(() {
        isLoading = false;
      });
      if (message[0] == GlobalVariable.verifySuc) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPassScreen(
              token: message[1],
            ),
          ),
        );
      } else {
        ShowSnackBar().showSnackBar(
            message[0], ColorLib.primaryColor, ColorLib.whiteColor, context);
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
