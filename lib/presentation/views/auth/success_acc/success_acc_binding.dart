import 'package:customer_order_app/presentation/views/auth/success_acc/success_acc_controller.dart';
import 'package:get/get.dart';

class SuccessAccBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuccessAccController());
  }
}
