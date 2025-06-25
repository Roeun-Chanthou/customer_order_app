import 'package:customer_order_app/presentation/views/auth/otp_verify/otp_verify_controller.dart';
import 'package:customer_order_app/presentation/widgets/custom_otpInput.dart';
import 'package:customer_order_app/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerifyView extends GetView<OtpVerifyController> {
  OtpVerifyView({super.key});

  late double screenHeight;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        elevation: 0,
        title: const Text(
          'OTP Verification',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Verification Code",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please enter the OTP sent to your email address.",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Center(
              child: CustomOtpInput(
                length: controller.otpLength,
                controllers: controller.otpControllers,
                focusNodes: controller.focusNodes,
                width: screenWidth * 0.12,
                // height: screenHeight * 0.06,
                borderRadius: 12,
                spacing: 10,
                fillColor: Colors.grey[50],
                borderColor: Colors.grey[300],
                focusedBorderColor: Theme.of(context).primaryColor,
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                onCompleted: (otp) {
                  controller.verifyOtp();
                },
                onChanged: (otp) {
                  controller.currentOtp.value = otp;
                },
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    controller.isLoading.value
                        ? null
                        : () {
                          if (controller.isAllFieldsFilled()) {
                            controller.verifyOtp();
                          } else {
                            controller.errorText.value =
                                'Please enter the complete OTP';
                          }
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child:
                    controller.isLoading.value
                        ? LoadingIndicator()
                        : const Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => Column(
                children: [
                  if (!controller.isResendEnabled.value)
                    Text(
                      'Resend code in ${controller.timerSeconds.value}s',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    )
                  else
                    TextButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : () {
                                controller.resendOtp();
                              },
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.resetScreen();
                  },
                  child: Text(
                    'Clear All',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Change Email',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
