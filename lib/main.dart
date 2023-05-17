import 'package:basic/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/login_controller.dart';

LoginController loginController = Get.put(LoginController());
var data = ''.obs;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkLogin();
    return const GetMaterialApp(
      home: SafeArea(
          child: Scaffold(
              body: CircularProgressIndicator()) /*Column(
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
}
