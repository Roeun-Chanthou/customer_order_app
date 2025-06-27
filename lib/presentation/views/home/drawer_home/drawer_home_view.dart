import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/data/services/auth_service.dart';
import 'package:customer_order_app/presentation/controllers/theme_controller.dart';
import 'package:customer_order_app/presentation/controllers/user_controller.dart';
import 'package:customer_order_app/presentation/views/home/drawer_home/drawer_home_controller.dart';
import 'package:customer_order_app/presentation/widgets/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

class DrawerHomeView extends GetView<DrawerHomeController> {
  const DrawerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>().user.value;
    return Drawer(
      // backgroundColor: Colors.white,
      child: SafeArea(
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
              Obx(
                () => SettingCard(
                  title: 'Dark Mode',
                  icon: Icons.dark_mode,
                  value: Get.find<ThemeController>().isDarkMode.value,
                  onChanged: (val) => Get.find<ThemeController>().toggleTheme(),
                ),
              ),
              SettingCard(
                value: null,
                title: 'Account Info',
                icon: Icons.info_outline,
                onChanged: (value) {},
              ),
              SettingCard(
                value: null,
                title: 'Password',
                icon: Icons.lock_outline,
              ),
              SettingCard(
                value: null,
                title: 'Order',
                icon: Icons.shopping_cart_outlined,
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
                  AuthService.logout();
                  Get.offAllNamed(RoutesName.onBording);
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
}
