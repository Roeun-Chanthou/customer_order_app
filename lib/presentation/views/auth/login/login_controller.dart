import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxBool obscurePS = true.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var isRememberMe = false.obs;
  var isPasswordVisible = false.obs;

  final RxBool isFormFilled = false.obs;

  late AnimationController _animationController;
  late Animation<double> shakeAnimation;

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(updateFormStatus);
    passwordController.addListener(updateFormStatus);

    emailController.clear();
    passwordController.clear();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticIn),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });

    clearForm();
  }

  void updateFormStatus() {
    isFormFilled.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  @override
  void onClose() {
    _animationController.dispose();
    emailController.removeListener(updateFormStatus);
    passwordController.removeListener(updateFormStatus);
    super.onClose();
  }

  void triggerShake() {
    _animationController.forward();
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    isRememberMe.value = false;
    isPasswordVisible.value = false;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      triggerShake();
      return;
    }

    isLoading.value = true;

    Get.offAllNamed(RoutesName.mainScreen);
    clearForm();
  }
}
