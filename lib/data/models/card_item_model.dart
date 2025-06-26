import 'package:customer_order_app/data/models/product_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  String get totalPrice => product.price * quantity;

  // For JSON serialization if needed
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(), // Assuming ProductModel has toJson method
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
