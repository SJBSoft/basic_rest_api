import 'dart:convert';

import 'package:basic/constant.dart';
import 'package:basic/models/UserModel.dart';
import 'package:basic/views/dashboard.dart';
import 'package:basic/views/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

checkLogin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref = await SharedPreferences.getInstance();
  String token = pref.getString('token') ?? '';
  Get.to(token != '' ? DashboardScreen() : LoginScreen());
}

Future<User> getUserData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token') ?? '';
  final response = await http.get(
    Uri.parse(userDataApi),
    headers: {'Accept': 'Application/json', 'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body)['user']);
  } else {
    throw Exception('Failed To laod');
  }
}

getUserDetails() async {
  final response = await http.get(Uri.parse('${userApi}1'));
  if (response.statusCode == 200) {
    var userData = User.fromJson(jsonDecode(response.body));
    print(userData.email);
    //apiResponse.data = User.fromJson(jsonDecode(response.body));
    //print('GGG'+response.body);
    // var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    // print(jsonResponse['user']['name']);
    //
    // print(user?.email);
    data.value = userData.email;
  } else {
    throw Exception('Error Getting Data');
  }
}

Future<List<User>> getAllUser() async {
  final response = await http.get(Uri.parse(allUser));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body)['users'];
    return jsonResponse.map((e) => User.fromJson(e)).toList();
  } else {
    throw Exception('Unexpected Error Occurs');
  }
}

logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token') ?? '';
  final response =
      await http.get(Uri.parse(logoutApi), headers: {'Accept': 'Accept/json',
        'Authorization': 'Bearer $token'
      });
  print(response.body);
  if(response.statusCode == 200){
    pref.setString('token', '');
    print(jsonDecode(response.body)['message']);
    checkLogin();
  }
}
