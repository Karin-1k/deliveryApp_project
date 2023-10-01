import 'dart:convert';

import 'package:dlivery_app_project/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.sharedPreferences});

  Future<http.Response> postUser(String url, dynamic body) async {
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: {
        "Content-type": "Application/json; charset=UTF-8"
        // "Authorization": "bearer $_token"
      });
      return response;
    } catch (e) {
      print('there is an err in postUser from auth-repo: ' + e.toString());
      return http.Response(e.toString(), 500);
    }
  }

  // login user method
  Future<http.Response> loginUser(String url, dynamic body) async {
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: {
        "Content-type": "Application/json; charset=UTF-8"
        // "Authorization": "bearer $_token"
      });
      saveToken(response.body);
      return response;
    } catch (e) {
      print('this err is occured' + e.toString());
      return http.Response(e.toString(), 500);
    }
  }

  void saveToken(dynamic body) {
    final convert = json.decode(body);
    sharedPreferences.setString(Constants.tokenKey, convert['token']);
   
  }

  // is available token
  bool isAvailableToken() {
    return sharedPreferences.containsKey(Constants.tokenKey);
  }

  // removing all saved from local storage!
  void removeAllLocalStrorage() {
    sharedPreferences.remove(Constants.tokenKey);
    sharedPreferences.remove(Constants.cartListhistoryKey);
    sharedPreferences.remove(Constants.cartListKey);
    
  }
}
