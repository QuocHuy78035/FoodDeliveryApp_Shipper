import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import '../../../main/views/navbar_custom.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/images/auth/splash/splash.json'),
      splashIconSize: 250,
      backgroundColor: Colors.black,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      // nextScreen: Provider.of<UserProvider>(context).user.accessToken != ""
      //     ? const CustomerHomeScreen()
      //     : const LoginScreen(),
      nextScreen: CustomerHomeScreen(),
    );
  }
}