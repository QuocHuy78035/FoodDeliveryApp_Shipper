import 'dart:convert';

import 'package:ddnangcao_project/features/profile/controllers/i_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/global_variable.dart';
import '../../auth/views/merchant_auth/login_screen.dart';

class ProfileController implements IProfile {

  Future<String> logoutUser() async {
    late String resMessage;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String accessToken = preferences.getString("accessToken") ?? "";
    String userId = preferences.getString("userId") ?? "";
    final response = await http.post(
      Uri.parse('${GlobalVariable.apiUrl}/logout'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accessToken,
        "x-client-id": userId
      },
    );
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
    } //showSnackBar(context, e.toString());
  }
}
