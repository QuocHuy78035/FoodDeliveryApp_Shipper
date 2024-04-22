import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/features/auth/views/merchant_auth/forgot_pass_screen.dart';
import 'package:ddnangcao_project/features/auth/views/merchant_auth/register_screen.dart';
import 'package:ddnangcao_project/features/main/views/navbar_custom.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:ddnangcao_project/widgets/base_button.dart';
import 'package:ddnangcao_project/widgets/base_input.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:ddnangcao_project/utils/validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../../../utils/global_variable.dart';
import '../../widgets/facebook_button.dart';
import '../../widgets/google_button.dart';
import '../../widgets/text_navigator.dart';
import '../../widgets/title_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final AuthController authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });



      String message = await authController.loginUser(email, password, context);

      setState(() {
        isLoading = false;
      });
      if (message == GlobalVariable.loginSuc) {
        ShowSnackBar().showSnackBar(message, Colors.green, Colors.black, context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomerHomeScreen(),
          ),
        );
      } else {
        ShowSnackBar().showSnackBar(message, ColorLib.primaryColor, Colors.white, context);
      }
      //firebase
      await authController.signInWithEmailAndPass(email, password);
    } else {
      ShowSnackBar().showSnackBar(
          GlobalVariable.fillAllField, ColorLib.primaryColor, Colors.white, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Distance(
                    height: GetSize.distance * 6,
                  ),
                  const TitleScreen(
                    title: "Merchant Login",
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
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
                    type: "Email",
                    hintText: "Your email",
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                      return GlobalVariable.enterPass;
                      }
                      // } else if (value.length < 8) {
                      //   return GlobalVariable.passValidator;
                      // }
                      return null;
                    },
                    type: "Password",
                    hintText: "Your password",
                    isPass: true,
                  ),
                  TextNavigator(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    title: "Forgot password?",
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  SizedBox(
                    height: GetSize.getHeight(context) * 0.06,
                    width: GetSize.getWidth(context),
                    child: BaseButton(
                      onPressed: () async {

                        //sqlite
                        //await DatabaseHelper.saveUser('example', email, password);
                        login();
                      },
                      titleRow: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                color: ColorLib.whiteColor,
                              ),
                            ),
                    ),
                  ),
                  const Distance(
                    height: GetSize.distance,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextNavigator(
                        title: "Sign Up",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  const Distance(
                    height: GetSize.distance * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Line(
                        width: GetSize.getWidth(context) * 0.2,
                      ),
                      const Distance(
                        width: GetSize.distance,
                      ),
                      const Text("Or Sign in with"),
                      const Distance(
                        width: GetSize.distance,
                      ),
                      Line(
                        width: GetSize.getWidth(context) * 0.2,
                      ),
                    ],
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  FaceBookButton(onPressed: () {}),
                  const Distance(
                    height: GetSize.distance,
                  ),
                  GoogleButton(onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  final double width;

  const Line({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: width,
      color: ColorLib.blackColor,
    );
  }
}

class Distance extends StatelessWidget {
  final double? height;
  final double? width;

  const Distance({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }
}
