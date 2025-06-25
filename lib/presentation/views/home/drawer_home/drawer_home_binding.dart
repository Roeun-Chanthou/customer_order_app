import 'package:customer_order_app/presentation/views/home/drawer_home/drawer_home_controller.dart';
import 'package:get/get.dart';

class DrawerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DrawerHomeController());
  }
}
