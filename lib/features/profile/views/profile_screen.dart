import 'package:ddnangcao_project/features/menu/views/add_food_screen.dart';
import 'package:ddnangcao_project/features/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../auth/views/merchant_auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = ProfileController();

  logoutUser() async{
    String message = await profileController.logoutUser();
    profileController.logOut(context);
    debugPrint(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                //logoutUser();
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text("Log Out"),
                    content: Text("Are you sure to Log out?"),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("Yes"),
                        onPressed: () async {
                          logoutUser();
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
              child: Text("Log Out"),
            ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddFoodScreen()));
          }, child: Text("Up load"))
        ],
      ),
    );
  }
}
