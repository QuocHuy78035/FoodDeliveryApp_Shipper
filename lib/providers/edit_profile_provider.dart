import 'package:ddnangcao_project/features/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import '../models/profile.dart';

class EditProfileProvider extends ChangeNotifier{
  UserResponse userResponse = UserResponse();
  final ProfileController profileController = ProfileController();
  String? name = '';
  String? address = '';

  Future<UserResponse> getInfoUser() async {
    UserResponse response = await profileController.getInfoProfile();
    userResponse = response;
    notifyListeners();
    return response;
  }
}