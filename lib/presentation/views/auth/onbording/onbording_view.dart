import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/presentation/views/auth/onbording/onbording_controller.dart';
import 'package:customer_order_app/presentation/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemesApp.textHintColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                    // image: DecorationImage(
                    //   image: AssetImage('assets/images/user.jpg'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemesApp.textDarkColor,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Discover the best products and services tailored just for you.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: ThemesApp.cardColor),
              ),
              Spacer(),
              CustomButton(
                text: 'Get Start',
                onPressed: () {
                  Get.toNamed(RoutesName.loginScreen);
                },
                backgroundColor: ThemesApp.textSuccessColor,
                borderRadius: 20,
                textColor: Colors.white,
              ),
              SizedBox(height: 16),
              CustomButton(
                text: "I'm new, sign me up",
                onPressed: () {
                  Get.toNamed(RoutesName.registerScreen);
                },
                borderRadius: 20,
                outlineColor: Colors.grey.shade400,
                textColor: ThemesApp.textDarkColor,
                value: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
