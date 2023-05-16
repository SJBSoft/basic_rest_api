import 'dart:convert';

import 'package:basic/constant.dart';
import 'package:basic/models/UserModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

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
        print(jsonResponse['token']);
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

getUserDetails() async {
  final response = await http.get(Uri.parse('${userApi}1'));
  if(response.statusCode == 200){
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
  }else{
    throw Exception('Error Getting Data');
  }
}

Future<List<User>>getAllUser() async {
  final response = await http.get(Uri.parse(allUser));
  if(response.statusCode == 200){
    List jsonResponse = jsonDecode(response.body)['users'];
    return jsonResponse.map((e) => User.fromJson(e)).toList();
  }else{
    throw Exception('Unexpected Error Occurs');
  }
}