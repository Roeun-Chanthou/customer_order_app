import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/presentation/controllers/user_controller.dart';
import 'package:customer_order_app/presentation/views/auth/success_acc/success_acc_controller.dart';
import 'package:customer_order_app/presentation/widgets/custom_buttom.dart';
import 'package:customer_order_app/presentation/widgets/custom_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessAccView extends GetView<SuccessAccController> {
  const SuccessAccView({super.key});

  @override
  Widget build(BuildContext context) {
    CustomSize.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/success.png",
                width: CustomSize.screenWidth * 0.6,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text('Your account successfully created!'),
              const SizedBox(height: 30),
              Text(
                "Your account has successfully created. You can go to login page first to login into your account!",
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Continue',
                borderRadius: 30,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  final user = Get.find<UserController>().user.value;

                  Get.offAllNamed(RoutesName.mainScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
