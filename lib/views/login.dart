import 'package:basic/views/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: loginController.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: loginController.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences pref = await SharedPreferences.getInstance();
                loginController.login(loginController.emailController.value.text, loginController.passwordController.value.text);
                /* _.isLoggedIn.value = !_.isLoggedIn.value;
                    Get.snackbar('Hi', _.isLoggedIn.value.toString(), snackPosition: SnackPosition.BOTTOM);*/
                Get.snackbar('Hi', loginController.emailController.value.text.toString(), snackPosition: SnackPosition.BOTTOM);
                print(await pref.getString('token') ?? '');
                //_.login();
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.to(SignUpScreen());
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}