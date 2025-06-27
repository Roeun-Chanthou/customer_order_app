import 'package:customer_order_app/presentation/views/auth/success_login/success_login_controller.dart';
import 'package:get/get.dart';

class SuccessLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuccessLoginController());
  }
}
