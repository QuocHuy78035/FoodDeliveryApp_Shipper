import 'dart:io';
import 'package:ddnangcao_project/features/profile/controllers/profile_controller.dart';
import 'package:ddnangcao_project/features/profile/views/edit_profile/edit_address_screen.dart';
import 'package:ddnangcao_project/features/profile/views/edit_profile/edit_email_screen.dart';
import 'package:ddnangcao_project/features/profile/views/edit_profile/edit_mobile_screen.dart';
import 'package:ddnangcao_project/features/profile/views/edit_profile/edit_name_screen.dart';
import 'package:ddnangcao_project/providers/edit_profile_provider.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/profile.dart';
import '../../../main/views/navbar_custom.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController profileController = ProfileController();

  UserResponse userResponse = UserResponse();
  String address = '';
  File? _image;
  String nameChange = "";
  String mobileChange = "";
  String gender = "";
  String email = "";

  //static const List<String> list = <String>['Men', 'Women', 'Other'];
  //String dropdownValue = list.first;

  _selectCameraImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    final im = await _imagePicker.pickImage(source: ImageSource.camera);
    if (im != null) {
      setState(() {
        _image = File(im.path);
      });
    }
  }

  getAddress() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      address = sharedPreferences.getString("address") ?? "";
    });
  }

  _navigateToEditNameScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNameScreen(
          name: userResponse.user!.name,
        ),
      ),
    );
    return result;
  }

  _navigateToEditMobileScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMobileScreen(
          mobile: userResponse.user!.mobile,
        ),
      ),
    );
    return result;
  }

  navigateToGScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNameScreen(
          name: userResponse.user!.name,
        ),
      ),
    );

    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
    Provider.of<EditProfileProvider>(context, listen: false)
        .getInfoUser()
        .then((response) {
      setState(() {
        userResponse = response;
      });
      nameChange = userResponse.user!.name;
      mobileChange = userResponse.user!.mobile;
      gender = userResponse.user!.gender;
      email = userResponse.user!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        actions: [
          GestureDetector(
            onTap: () async {
              EasyLoading.show();
              await profileController.editProfile(
                  nameChange,
                  gender,
                  userResponse.user!.dateOfBirth.toString(),
                  _image!,
                  address,
                  mobileChange);
              EasyLoading.dismiss();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomerHomeScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 18,
                    color: _image != null ||
                            nameChange != userResponse.user?.name ||
                            mobileChange != userResponse.user?.mobile
                        ? Colors.red
                        : Colors.grey),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: _image == null
                      ? CircleAvatar(
                          radius: 80,
                          //backgroundColor: ColorLib.primaryColor,
                          backgroundImage:
                              NetworkImage("${userResponse.user?.avatar}"),
                        )
                      // CachedNetworkImage(
                      //   fit: BoxFit.fill,
                      //   imageUrl: '${userResponse.user?.avatar}',
                      //   placeholder: (context, url) => const SizedBox(
                      //     height: 100,
                      //     width: 100,
                      //     child: Center(
                      //       child: CircularProgressIndicator(),
                      //     ),
                      //   ),
                      //   errorWidget: (context, url, error) => const SizedBox(
                      //     height: 100,
                      //     width: 100,
                      //     child: Center(
                      //       child: CircularProgressIndicator(),
                      //     ),
                      //   ),
                      : SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                Positioned(
                    top: 100,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        _selectCameraImage();
                      },
                      child: const Icon(
                        Icons.photo_camera,
                        size: 34,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            UserInfo(
              onTapProperties1: () async {
                nameChange = await _navigateToEditNameScreen(context);
              },
              onTapProperties2: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditAddressScreen(address: address),
                  ),
                );
              },
              properties1: "Name",
              properties2: "Address",
              valueOfProperties1:
                  nameChange == "" ? "${userResponse.user?.name}" : nameChange,
              valueOfProperties2: address,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 20,
              width: GetSize.getWidth(context),
              color: Colors.grey.withOpacity(.2),
            ),
            const SizedBox(
              height: 20,
            ),
            UserInfo(
              onTapProperties1: () {
                print('object');
                // DropdownMenu<String>(
                //   initialSelection: list.first,
                //   onSelected: (String? value) {
                //     // This is called when the user selects an item.
                //     setState(() {
                //       dropdownValue = value!;
                //     });
                //   },
                //   dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                //     return DropdownMenuEntry<String>(value: value, label: value);
                //   }).toList(),
                // );
              },
              onTapProperties2: () {},
              properties1: "Gender",
              properties2: "Date Of Birth",
              valueOfProperties1: "${userResponse.user?.gender}",
              valueOfProperties2: "${userResponse.user?.dateOfBirth}",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 20,
              width: GetSize.getWidth(context),
              color: Colors.grey.withOpacity(.2),
            ),
            const SizedBox(
              height: 20,
            ),
            UserInfo(
              onTapProperties1: () async {
                mobileChange = await _navigateToEditMobileScreen(context);
              },
              onTapProperties2: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEmailScreen(email: email),
                  ),
                );              },
              properties1: "Mobile",
              properties2: "Email",
              valueOfProperties1: mobileChange == ""
                  ? "${userResponse.user?.mobile}"
                  : mobileChange,
              valueOfProperties2: "${userResponse.user?.email}",
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String properties1;
  final String properties2;
  final String valueOfProperties1;
  final String valueOfProperties2;
  final void Function() onTapProperties1;
  final void Function() onTapProperties2;

  const UserInfo(
      {super.key,
      required this.properties1,
      required this.properties2,
      required this.valueOfProperties1,
      required this.onTapProperties1,
      required this.onTapProperties2,
      required this.valueOfProperties2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTapProperties1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  properties1,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      valueOfProperties1,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.navigate_next)
                  ],
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: onTapProperties2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  properties2,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: GetSize.getWidth(context) * .4,
                      child: Text(
                        valueOfProperties2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.navigate_next)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
