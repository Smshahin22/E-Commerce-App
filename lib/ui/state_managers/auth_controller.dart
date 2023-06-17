import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/profile_model.dart';
import '../screens/email_verification_screen.dart';

class AuthController extends GetxController {
  static String? _token;
  static ProfileData? _profileData;

  static String? get token => _token;
  static ProfileData? get profile => _profileData;

  Future<bool> isLoggedIn() async {
    await getToken();
    getProfileData();
    return _token != null;
  }

  Future<void> saveToken(String userToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = userToken;
    await preferences.setString('crafty_token', userToken);
  }

  Future<void> saveProfileData(ProfileData profile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _profileData = profile;
    await preferences.setString('user_profile', profile.toJson().toString());
  }

  Future<void> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString('crafty_token');
  }

  Future<void> getProfileData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _profileData = ProfileData.fromJson(
        jsonDecode(preferences.getString('user_profile') ?? '{}'));
  }

  Future<void> clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    _token = null;
  }

  Future<void> logOut() async {
    await clearUserData();
    Get.to(const EmailVerificationScreen());
  }

  Future<bool> checkAuthValidition() async {
    final authState = await Get.find<AuthController>().isLoggedIn();
    if (authState == false) {
      Get.to(const EmailVerificationScreen());
    }
    return authState;
  }
}
