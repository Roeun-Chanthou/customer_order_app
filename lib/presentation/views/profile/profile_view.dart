import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/data/services/auth_service.dart';
import 'package:customer_order_app/presentation/controllers/user_controller.dart';
import 'package:customer_order_app/presentation/views/profile/profile_controller.dart';
import 'package:customer_order_app/presentation/widgets/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>().user.value;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: ThemesApp.secondaryColor,
                    backgroundImage: (user!.photo.isNotEmpty)
                        ? NetworkImage(user.photo)
                        : null,
                    child: (user.photo.isEmpty)
                        ? Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Verified Profile",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Obx(
              //   () => SettingCard(
              //     title: 'Dark Mode',
              //     icon: Icons.dark_mode,
              //     value: Get.find<ThemeController>().isDarkMode.value,
              //     onChanged: (val) => Get.find<ThemeController>().toggleTheme(),
              //   ),
              // ),
              Bounceable(
                onTap: () {
                  Get.toNamed(RoutesName.accountInfo);
                },
                child: SettingCard(
                  value: null,
                  title: 'Account Info',
                  icon: Icons.info_outline,
                  onChanged: (value) {},
                ),
              ),
              SettingCard(
                value: null,
                title: 'Password',
                icon: Icons.lock_outline,
              ),
              Bounceable(
                onTap: () {
                  Get.toNamed(RoutesName.myOrder);
                },
                child: SettingCard(
                  value: null,
                  title: 'My Order',
                  icon: Icons.shopping_cart_outlined,
                ),
              ),
              Bounceable(
                onTap: () {
                  Get.toNamed(RoutesName.orderHistory);
                },
                child: SettingCard(
                  value: null,
                  title: 'Order History',
                  icon: Icons.shopping_cart_outlined,
                ),
              ),
              SettingCard(
                value: null,
                title: 'Settings',
                icon: Icons.settings,
                onChanged: (value) {},
              ),
              Spacer(),
              Bounceable(
                onTap: () {
                  _showLogoutDialog();
                },
                child: SettingCard(
                  value: null,
                  title: 'Logout',
                  icon: Icons.logout_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.logout_outlined,
                color: Colors.red,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout from your account?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                AuthService.logout();
                Get.offAllNamed(RoutesName.onBording);
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
