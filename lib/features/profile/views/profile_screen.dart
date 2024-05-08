import 'package:ddnangcao_project/features/profile/controllers/profile_controller.dart';
import 'package:ddnangcao_project/features/profile/views/edit_profile/edit_profile_screen.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/profile.dart';
import '../../../providers/edit_profile_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/color_lib.dart';
import '../../auth/views/merchant_auth/login_screen.dart';
import '../../auth/views/merchant_auth/register_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = ProfileController();
  int coin = 0;
  String token = '';
  UserResponse userResponse = UserResponse();

  checkLoginUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString("accessToken") ?? "";
    });
  }

  logoutUser() async {
    String message = await profileController.logoutUser();
    profileController.logOut(context);
    debugPrint(message);
  }

  @override
  void initState() {
    Provider.of<EditProfileProvider>(context, listen: false)
        .getInfoUser()
        .then((response) {
      setState(() {
        userResponse = response;
      });
    });
    checkLoginUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String? userName = Provider.of<UserProvider>(context).user.name;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage("${userResponse.user?.avatar}"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  token != ""
                      ? Text(
                        userResponse.user?.name ?? "",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 22,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
              },
              child: const NavFunction(
                icon: Icons.person,
                title: "My Profile",
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: const NavFunction(
                icon: Icons.location_on,
                title: "Delivery Address",
              ),
            ),
            const NavFunction(
              icon: Icons.contact_mail,
              title: "Contact Us",
            ),
            const NavFunction(
              icon: Icons.settings,
              title: "Settings",
            ),
            const NavFunction(
              icon: Icons.help,
              title: "Help & FAQ",
            ),
            const SizedBox(
              height: 20,
            ),
            token != ""
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2),
                    width: GetSize.getWidth(context),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorLib.primaryColor)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          foregroundColor: ColorLib.whiteColor),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: const Text("Log Out"),
                            content: const Text("Are you sure to Log out?"),
                            actions: <CupertinoDialogAction>[
                              CupertinoDialogAction(
                                child: const Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text("Yes"),
                                onPressed: () async {
                                  logoutUser();
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        );showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                            title: const Text("Log Out"),
                            content: const Text("Are you sure to Log out?"),
                            actions: <CupertinoDialogAction>[
                              CupertinoDialogAction(
                                child: const Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text("Yes"),
                                onPressed: () async {
                                  logoutUser();
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: ColorLib.primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Log Out",
                            style: TextStyle(
                                color: ColorLib.primaryColor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class NavFunction extends StatelessWidget {
  final String title;
  final IconData icon;

  const NavFunction({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: GetSize.symmetricPadding * 2,
          vertical: GetSize.symmetricPadding * 1.5),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: ColorLib.primaryColor,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
          // Container(
          //   width: GetSize.getWidth(context),
          //   color: ColorLib.greyColor,
          //   height: 1,
          // )
        ],
      ),
    );
  }
}
