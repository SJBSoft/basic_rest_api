import 'dart:convert';

import 'package:basic/constant.dart';
import 'package:basic/controller/login_controller.dart';
import 'package:basic/services/user_services.dart';
import 'package:basic/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'models/UserModel.dart';
import 'models/data.dart';


LoginController loginController = Get.put(LoginController());
var data = ''.obs;
void main() {

  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SafeArea(
          child: LoginScreen()/*Column(
            children: [
              Obx(() => Text(data.value)),
              Container(
                height: 500,
                width: 300,
                child: FutureBuilder<List<User>>(
                  future: getAllUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 75,
                              color: Colors.white,
                              child: Center(
                                child: Text(snapshot.data![index].name),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    // By default show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),*/
      ),
    );
  }

  @override
  void initState() {
    getUserDetails();
  }
}
