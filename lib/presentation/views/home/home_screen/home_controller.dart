import 'package:customer_order_app/data/models/product_model.dart';
import 'package:customer_order_app/data/services/product_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  var wishlist = <ProductModel>[].obs;

  var products = [].obs;
  var listCategori =
      <String>['T-Shirts', 'Hoodies', 'Jackets', 'Jeans', 'Pants', 'Shoes'].obs;
  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  void fetchProduct() async {
    try {
      isLoading(true);
      final result = await ProductService.getAllProduct();
      products.assignAll(result);
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading(false);
    }
  }

  void toggleWishlist(ProductModel product) {
    if (wishlist.any((p) => p.id == product.id)) {
      wishlist.removeWhere((p) => p.id == product.id);
    } else {
      wishlist.add(product);
    }
  }

  bool isWishlisted(String id) {
    return wishlist.any((p) => p.id.toString() == id);
  }
}
