import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/color_lib.dart';
import '../../../../utils/global_variable.dart';
import '../../../../utils/size_lib.dart';
import '../../../../widgets/base_button.dart';
import '../../../../widgets/base_input.dart';
import '../../widgets/title_screen.dart';
import 'login_screen.dart';

class ResetPassScreen extends StatefulWidget {
  final String token;

  const ResetPassScreen({super.key, required this.token});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final AuthController authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String password;
  late String passwordConfirm;
  bool isLoading = false;

  resetPass() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String message = await authController.resetPass(
          password, passwordConfirm, widget.token);
      setState(() {
        isLoading = true;
      });
      if (message == GlobalVariable.resetPassSuc) {
        final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// Get the current user
        User? currentUser = _firebaseAuth.currentUser;

        if (currentUser != null) {
          // Update the password
          currentUser.updatePassword(password)
              .then((_) {
            print("Password updated successfully!");
          })
              .catchError((error) {
            print("Password update failed: $error");
          });
        }
        ShowSnackBar()
            .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        ShowSnackBar().showSnackBar(
            message, ColorLib.primaryColor, ColorLib.whiteColor, context);
      }
    } else {
      ShowSnackBar().showSnackBar(GlobalVariable.fillAllField,
          ColorLib.primaryColor, ColorLib.whiteColor, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    type: "Password",
                    hintText: "Enter your password",
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return GlobalVariable.enterPass;
                      } else if (value.length < 8) {
                        return GlobalVariable.passValidator;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BaseInput(
                    type: "Password confirm",
                    hintText: "Enter your password confirm",
                    onChanged: (value) {
                      passwordConfirm = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return GlobalVariable.enterPassConfirm;
                      } else if (value.length < 8) {
                        return GlobalVariable.passValidator;
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
                        resetPass();
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
