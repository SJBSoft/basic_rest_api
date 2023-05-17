import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  register() async {
    try {
      final response = await http.post(Uri.parse(registerApi), headers: {
        'Accept': 'Application/json'
      }, body: {
        'name': nameController.text,
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordConfirmController.text
      });
      switch(response.statusCode){
        case 200:
          print(response.body);
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
    } catch (e) {}
  }
}
