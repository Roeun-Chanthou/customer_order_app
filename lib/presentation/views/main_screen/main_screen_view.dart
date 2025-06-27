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
    return Obx(
      () {
        return Scaffold(
          // backgroundColor: Colors.white,
          appBar: controller.currenIndex.value == 0 ? _buildAppBar() : null,
          drawer: controller.currenIndex.value == 0 ? DrawerHomeView() : null,
          body: IndexedStack(
            index: controller.currenIndex.value,
            children: controller.list,
          ),
          bottomNavigationBar: BottomNavigationBar(
            // backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currenIndex.value,
            onTap: (index) => controller.currenIndex.value = index,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedItemColor: ThemesApp.secondaryColor,
            items: [
              BottomNavigationBarItem(
                icon: controller.currenIndex.value == 0
                    ? Icon(
                        Icons.other_houses_rounded,
                        size: 26,
                      )
                    : Icon(
                        Icons.other_houses_outlined,
                        size: 26,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: controller.currenIndex.value == 1
                    ? Icon(
                        Icons.favorite,
                        size: 26,
                      )
                    : Icon(
                        Icons.favorite_border_outlined,
                        size: 26,
                      ),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: controller.currenIndex.value == 2
                    ? Icon(
                        Icons.shopping_cart,
                        size: 26,
                      )
                    : Icon(
                        Icons.shopping_cart_outlined,
                        size: 26,
                      ),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
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
                // color: Colors.white,
                color: ThemesApp.secondaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/icons/menu copy.svg',
                  // width: 24,
                  // height: 24,
                  color: Colors.white,
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
              color: ThemesApp.secondaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
