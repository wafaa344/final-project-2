import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Routes/routes.dart';
import '../basics/app_colors.dart';
import '../logout/logout_controller.dart';
import '../myprojects/get_projects_screen.dart';
import '../profile/profile_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = Get.find();

    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: const Text(
                'قائمة كرافتي',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('الملف الشخصي'),
              onTap: () {
               // Get.to(ProfileScreen());
               Get.toNamed(AppRoutes.profilepage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('مشاريعي'),
              onTap: () {
                Get.to(MyProjectsScreen());
                // Get.toNamed(AppRoutes.profilepage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('تسجيل الخروج'),
              onTap: () {
                logoutController.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
