import 'dart:convert';
import 'dart:io';
import 'package:ddnangcao_project/features/profile/controllers/i_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_services.dart';
import '../../../models/profile.dart';
import '../../auth/views/merchant_auth/login_screen.dart';

class ProfileController implements IProfile {
  final ApiServiceImpl apiService = ApiServiceImpl();

  Future<String> logoutUser() async {
    final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
    late String resMessage;
    final response = await apiServiceImpl.post(url: "logout", params: {});
    final Map<String, dynamic> data = jsonDecode(response.body);
    resMessage = data["message"];
    return resMessage;
  }

  @override
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('accessToken', '');
      await sharedPreferences.setString("userId", "");
      await sharedPreferences.setString("email", "");
      await sharedPreferences.setString("name", "");
      await sharedPreferences.setString("refreshToken", "");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserResponse> getInfoProfile() async {
    UserResponse userResponse = UserResponse();
    final response = await apiService.get(url: "user");
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (data['status'] == 200) {
      userResponse = UserResponse.fromJson(data);
    } else {
      print("Fail to edit profile");
    }
    return userResponse;
  }

  @override
  Future<int> editProfile(String name, String gender, String dateOfBirth, File avatar,
      String address, String mobile) async {
    int status = 0;
    final response = await apiService
        .patchFormData(url: "user/profile", nameFieldImage: "avatar", params: {
      "name": name,
      "gender": gender,
      "dateOfBirth": dateOfBirth,
      "avatar" : avatar,
      "address": address,
      "mobile": mobile
    });
    final Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    return status = data['status'];
  }
}
