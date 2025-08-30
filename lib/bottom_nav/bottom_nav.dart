import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Routes/routes.dart';
import '../basics/app_colors.dart';
import '../payments/start_wallet_page.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomBar({super.key, required this.currentIndex});

  void onTabTapped(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.home); // الصفحة الرئيسية
        break;
      case 1:
        Get.offAllNamed(AppRoutes.projectpage); // مشاريعي
        break;
      case 2:
        Get.offAll( StartWalletPage());        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      backgroundColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
      onTap: onTabTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'مشاريعي',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: 'المحفظة',
        ),
      ],
    );
  }
}
