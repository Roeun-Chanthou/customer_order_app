import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/presentation/views/auth/forget_ps/forget_ps_controller.dart';
import 'package:customer_order_app/presentation/widgets/custom_buttom.dart';
import 'package:customer_order_app/presentation/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPsView extends GetView<ForgetPsController> {
  ForgetPsView({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Forget Password")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please fill your email to go to next step"),
              SizedBox(height: 20),
              CustomTextField(
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email_outlined),
                shakeAnimation: controller.shakeAnimation,
                controller: controller.txtEmailCtl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 45),
              CustomButton(
                backgroundColor: ThemesApp.textSuccessColor,
                textColor: Colors.white,
                text: 'Submit',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.submitEmailClick();
                  } else {
                    controller.triggerShake();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
