import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var txtEmailCtl = TextEditingController();
  final RxBool isFormFilled = false.obs;

  late AnimationController _animationController;
  late Animation<double> shakeAnimation;

  @override
  void onInit() {
    super.onInit();

    txtEmailCtl.addListener(updateFormStatus);

    txtEmailCtl.clear();

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

  void submitEmailClick() {
    if (txtEmailCtl.text.isEmpty) {
      _animationController.forward();
    } else {
      Get.toNamed(RoutesName.otpForgetPsVerify);
    }
  }

  void updateFormStatus() {
    isFormFilled.value = txtEmailCtl.text.isNotEmpty;
  }

  @override
  void onClose() {
    _animationController.dispose();
    txtEmailCtl.removeListener(updateFormStatus);
    super.onClose();
  }

  void triggerShake() {
    _animationController.forward();
  }

  void clearForm() {
    txtEmailCtl.clear();
  }
}
