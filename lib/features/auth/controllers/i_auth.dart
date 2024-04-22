import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class IAuth{
  Future<String> loginUser(String email, String password, BuildContext context);
  Future<String> registerUser(String name, String email, String password, String passwordConfirm);
  Future<int> forgotPass(String email);
  Future<List<String>> verifyForgotPass(String email, String otp);
  Future<String> verifySignUp(String email, String otp, BuildContext context);
  Future<String> resetPass(String password, String passwordConfirm, String token);
  Future<UserCredential> signInWithEmailAndPass(String email,
      String password);
  Future<UserCredential> signUpWithEmailAndPass(String email,
      String password, String userId);
  Future<String> registerStore(String storeName, String address, File? image, String timeOpen, String timeClose, String latitude, String longtitude);

}