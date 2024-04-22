import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/features/auth/views/merchant_auth/verify_forgot_pass_screen.dart';
import 'package:ddnangcao_project/features/auth/widgets/title_screen.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:ddnangcao_project/utils/validator/email_validator.dart';
import 'package:ddnangcao_project/widgets/base_button.dart';
import 'package:ddnangcao_project/widgets/base_input.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  bool isLoading = false;

  void forgotPass() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      int statusCode = await authController.forgotPass(email);
      setState(() {
        isLoading = false;
      });
      if (statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyScreen(
              email: email,
            ),
          ),
        );
      } else {
        ShowSnackBar().showSnackBar("Some thing is wrong, pleas retry again",
            ColorLib.primaryColor, ColorLib.whiteColor, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding * 2),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const TitleScreen(title: "Reset Password"),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      GlobalVariable.resetPassTitle),
                  const SizedBox(
                    height: 30,
                  ),
                  BaseInput(
                    type: "Email",
                    hintText: "Enter your email",
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return GlobalVariable.enterEmail;
                      } else if (value.isVailEmail() == false) {
                        return GlobalVariable.emailValidator;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: GetSize.getHeight(context) * 0.1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: BaseButton(
                      onPressed: () async {
                        forgotPass();
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
