import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/presentation/views/home/drawer_home/drawer_home_controller.dart';
import 'package:customer_order_app/presentation/widgets/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DrawerHomeView extends GetView<DrawerHomeController> {
  const DrawerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemesApp.textBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    'assets/icons/menu copy.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dom SlanhOun",
                        style: TextStyle(
                          fontSize: 20,
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
              SettingCard(
                title: 'Dark Mode',
                icon: 'assets/icons/sun.svg',
                onChanged: (value) {},
                value: true,
              ),
              SettingCard(
                title: 'Account Info',
                icon: 'assets/icons/Info Circle.svg',
                // onChanged: (value) {},
              ),
              SettingCard(
                title: 'Password',
                icon: 'assets/icons/Lock.svg',
                // onChanged: (value) {},
              ),
              SettingCard(
                title: 'Order',
                icon: 'assets/icons/Vector copy.svg',
                // onChanged: (value) {},
              ),
              SettingCard(
                title: 'My Card',
                icon: 'assets/icons/Wallet.svg',
                onChanged: (value) {},
              ),
              SettingCard(
                title: 'Wishlist',
                icon: 'assets/icons/Heart.svg',
                // onChanged: (value) {},
              ),
              SettingCard(
                title: 'Settings',
                icon: 'assets/icons/Setting.svg',
                onChanged: (value) {},
              ),
              Spacer(),
              Bounceable(
                onTap: () => Get.offAllNamed(RoutesName.onBording),
                child: SettingCard(
                  title: 'Logout',
                  icon: 'assets/icons/Lock.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
