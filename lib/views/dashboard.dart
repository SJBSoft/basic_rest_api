import 'package:basic/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import 'home.dart';

class DashboardScreen extends StatelessWidget {
  var selectedIndex = 0.obs;
  final controller = PageController(
      initialPage: 0
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
        children: [
          HomeScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: Obx(()=>SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          selectedIndex.value = index;
          controller.animateToPage(selectedIndex.value,
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastLinearToSlowEaseIn);
        },
        iconSize: 30,
        activeColor: const Color(0xFF01579B),
        selectedIndex: selectedIndex.value,
        barItems: [
          BarItem(
            icon: Icons.home_outlined,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.account_box_outlined,
            title: 'Profile',
          ),
          /// Add more BarItem if you want
        ],
      )),
    );
  }
}
