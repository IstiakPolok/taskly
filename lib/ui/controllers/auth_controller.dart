import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/data/models/user_model.dart';

class AuthController {
  static String?  accessToken;
  static UserModel?  userModel;

  static String _accessTokenkey = 'access-token';
  static String _userDataKey  = 'user-data';


  static Future<void> saveUserData(String accessToken, UserModel model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenkey, accessToken);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
  }

  static Future<void> getuserData() async {
    SharedPreferences sharedPreferences  = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenkey);
    String? userdata = sharedPreferences.getString(_userDataKey);
    accessToken = token;
    userModel = UserModel.fromJson(jsonDecode(userdata!));
  }

  static Future<bool> isUserLoggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenkey);
    if (token != null) {
      await getuserData();
      return true;
    }
    return false;
  }
  static Future<void> clearUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}