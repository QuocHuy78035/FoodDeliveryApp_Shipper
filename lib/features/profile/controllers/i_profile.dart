import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../models/profile.dart';


abstract class IProfile{
  void logOut(BuildContext context);
  Future<UserResponse> getInfoProfile();
  Future<int> editProfile(String name, String gender, String dateOfBirth, File avatar, String address, String mobile);
}