import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateNewPsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxBool obscurePS = true.obs;
  final RxBool obscureConfirmPS = true.obs;
  var txtPasswordCtl = TextEditingController();
  var txtConfirmPasswordCtl = TextEditingController();
  final RxBool isFormFilled = false.obs;

  late AnimationController _animationController;
  late Animation<double> shakeAnimation;

  @override
  void onInit() {
    super.onInit();

    txtPasswordCtl.addListener(updateFormStatus);
    txtConfirmPasswordCtl.addListener(updateFormStatus);

    txtPasswordCtl.clear();
    txtConfirmPasswordCtl.clear();

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

  void changePasswordClick() {
    if (txtPasswordCtl.text.isEmpty || txtConfirmPasswordCtl.text.isEmpty) {
      _animationController.forward();
    } else {
      Get.toNamed(RoutesName.loginScreen);
    }
  }

  void updateFormStatus() {
    isFormFilled.value = txtPasswordCtl.text.isNotEmpty;
    isFormFilled.value = txtConfirmPasswordCtl.text.isNotEmpty;
  }

  @override
  void onClose() {
    _animationController.dispose();
    txtPasswordCtl.removeListener(updateFormStatus);
    txtConfirmPasswordCtl.removeListener(updateFormStatus);
    super.onClose();
  }

  void triggerShake() {
    _animationController.forward();
  }

  void clearForm() {
    txtPasswordCtl.clear();
    txtConfirmPasswordCtl.clear();
  }
}
