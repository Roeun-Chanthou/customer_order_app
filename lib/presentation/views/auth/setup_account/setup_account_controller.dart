import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetupAccountController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final fullName = TextEditingController();
  final phone = TextEditingController();
  final Rx<String> selectedGender = ''.obs;
  final isFormValid = false.obs;
  final RxBool isFormFilled = false.obs;
  late AnimationController _animationController;
  late Animation<double> shakeAnimation;

  final picker = ImagePicker();

  final imageUrl = ''.obs;
  final imageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fullName.addListener(checkFormValidity);
    phone.addListener(checkFormValidity);
    selectedGender.listen((_) => checkFormValidity());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticIn,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });
  }

  void profileClick() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageFile.value = File(image.path);
  }

  void triggerShake() {
    _animationController.forward();
  }

  void checkFormValidity() {
    isFormValid.value = fullName.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        selectedGender.value.isNotEmpty;
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  @override
  void onClose() {
    fullName.dispose();
    phone.dispose();
    super.onClose();
  }
}
