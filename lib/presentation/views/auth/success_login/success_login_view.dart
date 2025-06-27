import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:customer_order_app/presentation/controllers/user_controller.dart';
import 'package:customer_order_app/presentation/views/auth/success_login/success_login_controller.dart';
import 'package:customer_order_app/presentation/views/main_screen/main_screen_controller.dart';
import 'package:customer_order_app/presentation/views/main_screen/main_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SuccessLoginView extends GetView<SuccessLoginController> {
  const SuccessLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainScreenController());
    final user = Get.find<UserController>().user.value;
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Text("Welcome ${user!.fullName}"),
          Text("You have successfully logged in"),
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: MainScreenView(),
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
