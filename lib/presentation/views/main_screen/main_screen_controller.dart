import 'package:customer_order_app/presentation/views/cart/cart_view.dart';
import 'package:customer_order_app/presentation/views/home/home_screen/home_view.dart';
import 'package:customer_order_app/presentation/views/profile/profile_view.dart';
import 'package:customer_order_app/presentation/views/wishlist/wishlist_view.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  RxInt currenIndex = 0.obs;

  final list = [HomeView(), WishlistView(), CartView(), ProfileView()];
}
