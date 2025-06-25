import 'dart:async';

import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpForgetPsController extends GetxController {
  final int otpLength;
  final String email;

  var timerSeconds = 30.obs;
  var isResendEnabled = false.obs;
  var errorText = RxnString(null);
  var isLoading = false.obs;
  var currentOtp = ''.obs;

  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;

  Timer? _timer;

  OtpForgetPsController({this.otpLength = 6, this.email = ''});

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    startTimer();
  }

  @override
  void onReady() {
    super.onReady();
    resetScreen();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _disposeControllers();
    super.onClose();
  }

  void _initializeControllers() {
    otpControllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());

    for (int i = 0; i < otpControllers.length; i++) {
      otpControllers[i].addListener(() {
        _updateCurrentOtp();
        _clearError();
      });
    }
  }

  void _disposeControllers() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
  }

  void _updateCurrentOtp() {
    currentOtp.value = otpControllers.map((c) => c.text).join();
  }

  void _clearError() {
    if (errorText.value != null) {
      errorText.value = null;
    }
  }

  void startTimer() {
    _timer?.cancel();
    timerSeconds.value = 30;
    isResendEnabled.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  bool isAllFieldsFilled() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  String getCurrentOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  Future<void> verifyOtp() async {
    try {
      errorText.value = null;

      if (!isAllFieldsFilled()) {
        errorText.value = 'Please enter the complete OTP';
        return;
      }

      String otp = getCurrentOtp();

      if (otp.length != otpLength) {
        errorText.value = 'Please enter a valid $otpLength-digit OTP';
        return;
      }

      isLoading.value = true;

      // final response = await apiService.verifyOtp(email: email, otp: otp);
      // if (response.isSuccess) {
      //   // Handle success
      //   Get.offAllNamed('/home');
      // } else {
      //   errorText.value = response.message ?? 'Invalid OTP. Please try again.';
      // }

      Get.snackbar(
        'Success',
        'OTP verified successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(RoutesName.newPS);
    } catch (e) {
      errorText.value = 'An error occurred. Please try again.';
      print('OTP Verification Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    try {
      if (!isResendEnabled.value) return;

      isLoading.value = true;
      errorText.value = null;

      // await Future.delayed(const Duration(seconds: 1));

      // Example of API call structure:
      // final response = await apiService.resendOtp(email: email);
      // if (response.isSuccess) {
      //   // Handle success
      // } else {
      //   errorText.value = response.message ?? 'Failed to resend OTP';
      //   return;
      // }

      Get.snackbar(
        'OTP Sent',
        'A new OTP has been sent to your email',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );

      resetScreen();
    } catch (e) {
      errorText.value = 'Failed to resend OTP. Please try again.';
      print('Resend OTP Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetScreen() {
    _timer?.cancel();

    for (var controller in otpControllers) {
      controller.clear();
    }

    if (focusNodes.isNotEmpty) {
      focusNodes.first.requestFocus();
    }

    errorText.value = null;
    isResendEnabled.value = false;
    isLoading.value = false;
    currentOtp.value = '';

    startTimer();
  }

  void clearAllFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    currentOtp.value = '';
    errorText.value = null;
    if (focusNodes.isNotEmpty) {
      focusNodes.first.requestFocus();
    }
  }

  void pasteOtp(String otp) {
    if (otp.length == otpLength) {
      for (int i = 0; i < otpLength; i++) {
        otpControllers[i].text = otp[i];
      }
      _updateCurrentOtp();
      if (isAllFieldsFilled()) {
        verifyOtp();
      }
    }
  }

  void handleExternalOtpInput(String otp) {
    if (otp.isNotEmpty && otp.length <= otpLength) {
      clearAllFields();
      for (int i = 0; i < otp.length && i < otpLength; i++) {
        otpControllers[i].text = otp[i];
      }

      _updateCurrentOtp();

      int nextIndex = otp.length < otpLength ? otp.length : otpLength - 1;
      if (nextIndex < focusNodes.length) {
        focusNodes[nextIndex].requestFocus();
      }
    }
  }
}
