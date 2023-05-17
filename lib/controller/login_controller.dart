import 'dart:convert';

import 'package:basic/views/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../models/UserModel.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoggedIn = false.obs;


  login(String email, password) async {
    try{
      final response = await http.post(
          Uri.parse(loginApi),
          headers: {'Accept': 'appilcation/json'},
          body: {'email': email, 'password': password}
      );
      /*if(response.statusCode == 200){
      print(response.body);
      var datas = User.fromJson(jsonDecode(response.body)['user']);
      print(datas.email);
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['token']);
    }*/
      switch(response.statusCode){
        case 200:
          print(response.body);
          var datas = User.fromJson(jsonDecode(response.body)['user']);
          print(datas.email);
          var jsonResponse = jsonDecode(response.body);
          final SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('token', jsonResponse['token']);
          //print(jsonResponse['token']);
          Get.to(()=>DashboardScreen());
          break;
        case 422:
          print('422');
          final errors = jsonDecode(response.body)['errors'];
          //data = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          print('403');
          //data.error = jsonDecode(response.body)['message'];
          break;
        default:
          print('500');
          //data.error = 'somethingWentWrong';
          break;
      }
    }catch(e){
      print(e.toString());
    }
  }
}