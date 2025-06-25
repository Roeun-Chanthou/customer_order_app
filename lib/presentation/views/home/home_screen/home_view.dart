import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/data/models/product_model.dart';
import 'package:customer_order_app/presentation/views/home/home_screen/home_controller.dart';
import 'package:customer_order_app/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            SizedBox(height: 16),
            Text(
              "Hello, Dom!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Welcome to Caramel Shop"),
            SizedBox(height: 16),
            _buildSearchProduct(),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("Veiw All", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var item = controller.listCategori[index];
                  return _buildCategoriProduct(item);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 16);
                },
                itemCount: controller.listCategori.length,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "New Arraival",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text("Veiw All", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                var product = controller.products[index];
                return _buildGridProduct(product);
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSearchProduct() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: SvgPicture.asset('assets/icons/Search.svg'),
                ),
                hintText: 'Search...',
                fillColor: ThemesApp.primaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: ThemesApp.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.filter_list_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriProduct(item) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ThemesApp.textHintColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          item,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildGridProduct(ProductModel product) {
    return Bounceable(
      onTap: () {
        Get.toNamed(RoutesName.productDetailScreen, arguments: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade300,
                  ),
                  child: Hero(
                    tag: product.id,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: Obx(() {
                    final isFavorited = controller.isWishlisted(
                      product.id.toString(),
                    );
                    return Bounceable(
                      onTap: () => controller.toggleWishlist(product),
                      child: SvgPicture.asset(
                        isFavorited
                            ? 'assets/icons/Vector-1.svg'
                            : 'assets/icons/Heart.svg',
                        width: 24,
                        height: 24,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            product.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(
            "\$${product.price}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
