import 'package:customer_order_app/presentation/views/home/home_screen/home_controller.dart';
import 'package:customer_order_app/presentation/views/wishlist/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Whislist"), forceMaterialTransparency: true),
      body: Obx(() {
        if (homeController.wishlist.isEmpty) {
          return Center(child: Text("No items in wishlist"));
        }
        return ListView.builder(
          itemCount: homeController.wishlist.length,
          itemBuilder: (context, index) {
            final product = homeController.wishlist[index];
            return ListTile(
              leading: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => homeController.toggleWishlist(product),
              ),
            );
          },
        );
      }),
    );
  }
}
