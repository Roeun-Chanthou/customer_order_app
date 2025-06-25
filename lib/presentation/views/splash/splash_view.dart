import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // final controller = MainScreenController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _checkAuthAndNavigate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    // final isLoggedIn = await AuthService.isLoggedIn();
    final bool isLoggedIn = false;
    if (isLoggedIn == true) {
      Get.offNamed(RoutesName.mainScreen);
    } else {
      Get.offNamed(RoutesName.onBording);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/Group 288870.png',
              fit: BoxFit.cover,
              height: 150,
              width: 150,
            ),
          ],
        ),
      ),
    );
    // return AnimatedSplashScreen(
    //   splash: Image.asset(
    //     'assets/logo/Group 288870.png',
    //     fit: BoxFit.cover,
    //   ),
    //   backgroundColor: Colors.white,
    //   nextScreen: MainScreenView(),
    //   splashTransition: SplashTransition.rotationTransition,
    //   pageTransitionType: PageTransitionType.fade,
    // );
  }
}
