import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/presentation/views/home/drawer_home/drawer_home_view.dart';
import 'package:customer_order_app/presentation/views/main_screen/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: controller.currenIndex.value == 0 ? _buildAppBar() : null,
        drawer: controller.currenIndex.value == 0 ? DrawerHomeView() : null,
        body: IndexedStack(
          index: controller.currenIndex.value,
          children: controller.list,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currenIndex.value,
          onTap: (index) => controller.currenIndex.value = index,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: ThemesApp.secondaryColor,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                controller.currenIndex.value == 0
                    ? 'assets/icons/Home copy.svg'
                    : 'assets/icons/Home.svg',
                width: 24,
                height: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                controller.currenIndex.value == 1
                    ? 'assets/icons/Vector-1.svg'
                    : 'assets/icons/Heart.svg',
                width: 24,
                height: 24,
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                controller.currenIndex.value == 2
                    ? 'assets/icons/Vector.svg'
                    : 'assets/icons/Vector copy 3.svg',
                width: 24,
                height: 24,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                controller.currenIndex.value == 3
                    ? 'assets/icons/Vector.svg'
                    : 'assets/icons/Wallet.svg',
                width: 24,
                height: 24,
              ),
              label: 'Wallet',
            ),
          ],
        ),
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: false,
      leading: Builder(
        builder: (context) {
          return Bounceable(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ThemesApp.textHintColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/icons/menu.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ThemesApp.textHintColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/icons/Vector copy 3.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
