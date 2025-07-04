import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/data/services/order_service.dart';
import 'package:customer_order_app/presentation/controllers/user_controller.dart';
import 'package:customer_order_app/presentation/views/cart/cart_controller.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  Future<void> placeOrder(List cartItems, double total) async {
    final user = Get.find<UserController>().user.value;

    if (user == null) {
      Get.snackbar(
        'Unauthorized',
        'Please login to continue',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    final items = cartItems
        .map((item) => {
          
              'product_id': item.product.id,
              'quantity': item.quantity,
            })
        .toList();

    final result = await OrderService.placeOrder(
      customerId: user.cid,
      items: items,
    );

    final cartController = Get.find<CartController>();
    final isCartCheckout = cartItems.length == cartController.cartList.length &&
        cartItems.every((item) => cartController.cartList.any(
              (c) =>
                  c.product.id == item.product.id &&
                  c.quantity == item.quantity,
            ));

    if (result['success']) {
      if (isCartCheckout) {
        cartController.clearCart();
      }
      Get.offAllNamed(RoutesName.orderSuccess, arguments: {
        'orderId': result['order_id'],
        'total': cartItems.fold<double>(
          0,
          (sum, item) => sum + item.totalPrice,
        ),
      });
    } else {
      Get.snackbar(
        'Order Failed',
        result['message'] ?? 'Unknown error',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}
