import 'package:customer_order_app/data/models/card_item_model.dart';
import 'package:customer_order_app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  var quantity = 1.obs;
  var favoriteProducts = <String>[].obs;
  var cartItems = <CartItem>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
    loadCartItems();
  }

  // Quantity management
  void incrementQuantity(int maxStock) {
    if (quantity.value < maxStock) {
      quantity.value++;
    } else {
      Get.snackbar(
        'Stock Limit',
        'Cannot add more than available stock',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
      );
    }
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // Favorites management
  bool isFavorite(String productId) {
    return favoriteProducts.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (isFavorite(productId)) {
      favoriteProducts.remove(productId);
      Get.snackbar(
        'Removed from Favorites',
        'Product removed from your favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[600],
        colorText: Colors.white,
        icon: const Icon(Icons.favorite_border, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
    } else {
      favoriteProducts.add(productId);
      Get.snackbar(
        'Added to Favorites',
        'Product added to your favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.favorite, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
    }
    saveFavorites();
  }

  // Cart management
  void addToCart(ProductModel product) {
    if (product.stock <= 0) {
      Get.snackbar(
        'Out of Stock',
        'This product is currently out of stock',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return;
    }

    // Check if product already exists in cart
    int existingIndex =
        cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      // Update existing item
      CartItem existingItem = cartItems[existingIndex];
      int newQuantity = existingItem.quantity + quantity.value;

      if (newQuantity <= product.stock) {
        cartItems[existingIndex] = CartItem(
          product: product,
          quantity: newQuantity,
        );

        Get.snackbar(
          'Cart Updated',
          'Product quantity updated in cart',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Stock Limit Exceeded',
          'Cannot add more than available stock',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white),
        );
        return;
      }
    } else {
      // Add new item
      cartItems.add(CartItem(
        product: product,
        quantity: quantity.value,
      ));

      Get.snackbar(
        'Added to Cart',
        '${product.name} added to your cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        duration: const Duration(seconds: 2),
        mainButton: TextButton(
          onPressed: () => goToCart(),
          child: const Text('VIEW CART', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    saveCartItems();
    quantity.value = 1; // Reset quantity after adding to cart
  }

  // Buy Now functionality
  void buyNow(ProductModel product) {
    if (product.stock <= 0) {
      Get.snackbar(
        'Out of Stock',
        'This product is currently out of stock',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return;
    }

    // Create order item
    List<CartItem> orderItems = [
      CartItem(product: product, quantity: quantity.value)
    ];

    // Navigate to checkout with order items
    Get.toNamed('/checkout', arguments: {
      'items': orderItems,
      'totalAmount': product.price * quantity.value,
      'isDirectPurchase': true,
    });
  }

  // Navigation methods
  void goToCart() {
    Get.toNamed('/cart');
  }

  void goToCheckout() {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Empty Cart',
        'Add items to cart before checkout',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    double totalAmount = cartItems.fold(
      0.0,
      (sum, item) => sum + (double.parse(item.product.price) * item.quantity),
    );

    Get.toNamed('/checkout', arguments: {
      'items': cartItems.toList(),
      'totalAmount': totalAmount,
      'isDirectPurchase': false,
    });
  }

  // Data persistence methods (you can implement these with your preferred storage solution)
  void loadFavorites() {
    // Load favorites from local storage (SharedPreferences, Hive, etc.)
    // For now, we'll use a dummy implementation
    favoriteProducts.value = [];
  }

  void saveFavorites() {
    // Save favorites to local storage
    // Implementation depends on your storage solution
  }

  void loadCartItems() {
    // Load cart items from local storage
    // For now, we'll use a dummy implementation
    cartItems.value = [];
  }

  void saveCartItems() {
    // Save cart items to local storage
    // Implementation depends on your storage solution
  }

  // Helper methods
  int get totalCartItems =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get cartTotal => cartItems.fold(
        0.0,
        (sum, item) => sum + (double.parse(item.product.price) * item.quantity),
      );

  void clearCart() {
    cartItems.clear();
    saveCartItems();
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
    saveCartItems();

    Get.snackbar(
      'Removed from Cart',
      'Product removed from your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[600],
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void updateCartItemQuantity(String productId, int newQuantity) {
    int index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      if (newQuantity <= 0) {
        removeFromCart(productId);
      } else if (newQuantity <= cartItems[index].product.stock) {
        cartItems[index] = CartItem(
          product: cartItems[index].product,
          quantity: newQuantity,
        );
        saveCartItems();
      } else {
        Get.snackbar(
          'Stock Limit',
          'Cannot exceed available stock',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    }
  }
}
