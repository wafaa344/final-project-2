import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt pageIndex = 0.obs;

    final pages = [
      //const HomePage(),
      const Center(child: Text('مشروعي', style: TextStyle(fontSize: 24))),
      const Center(child: Text('حسابي', style: TextStyle(fontSize: 24))),
    ];

    return Obx(() => Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey[200]!,
        color: const Color(0xfff77520),
        buttonBackgroundColor: Colors.white,
        height: 60,
        animationDuration: const Duration(milliseconds: 400),
        index: pageIndex.value,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.business, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
        onTap: (index) => pageIndex.value = index,
      ),
      body: Stack(
        children: [
          Container(color: Colors.grey[200]),
          pages[pageIndex.value],
        ],
      ),
    ));
  }
}
