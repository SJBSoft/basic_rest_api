import 'package:flutter/material.dart';

const websiteUrl = 'http://10.0.2.2:8800/';
const baseURL = 'http://10.0.2.2:8800/api';
const loginApi = '$baseURL/login';
const registerApi = '$baseURL/register';
const allUser = '$baseURL/users';
const userApi = '$baseURL/users/';
const userDataApi = '$baseURL/user';

TextStyle profileTextStyle(){
  return TextStyle(fontSize: 20, color: Colors.blueAccent);
}