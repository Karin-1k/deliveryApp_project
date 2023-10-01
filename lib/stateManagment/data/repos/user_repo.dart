import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

class UserRepo {
  SharedPreferences sharedPreferences;
  UserRepo({required this.sharedPreferences});
  Future<http.Response> getUserInfo() async {
    try {
      http.Response response =
          await http.get(Uri.parse(Constants.USER_INFO), headers: {
        "Content-type": "Application/json; charset=UTF-8",
        "Authorization":
            "bearer ${sharedPreferences.getString(Constants.tokenKey)}"
      });
      if (json.decode(response.body)['success'] == 1) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return http.Response(e.toString(), 500);
    }
  }
}
