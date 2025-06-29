import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/data/models/product_model.dart';
import 'package:customer_order_app/presentation/controllers/user_controller.dart';
import 'package:customer_order_app/presentation/views/home/home_screen/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>().user.value;
    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              SizedBox(height: 16),
              Text(
                "Hello, ${user?.fullName}!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Welcome to Scarlet",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              _buildSearchProduct(),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Spacer(),
                  // Text(
                  //   "Veiw All",
                  //   style: TextStyle(fontSize: 16),
                  // ),
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
                  itemCount: controller.listCategori.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 16);
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "New Arraival",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  // Spacer(),
                  // Text("Veiw All", style: TextStyle(fontSize: 16)),
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
                  childAspectRatio: 1 / 1.6,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  var product = controller.filteredProducts[index];
                  return _buildGridProduct(product);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchProduct() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => controller.setSearchText(value),
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

  Widget _buildCategoriProduct(Map item) {
    final isSelected = controller.selectedCategoryId.value == item['id'];
    return GestureDetector(
      onTap: () => controller.setCategory(item['id']),
      child: Container(
        width: 90,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isSelected ? ThemesApp.secondaryColor : ThemesApp.textHintColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            item['name'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridProduct(ProductModel product) {
    return Bounceable(
      onTap: () {
        Get.toNamed(
          RoutesName.productDetailScreen,
          arguments: product,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              child: Hero(
                tag: product.id,
                child: Stack(
                  children: [
                    Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Obx(
                        () {
                          final isFavorited = controller.isWishlisted(
                            product.id.toString(),
                          );
                          return Bounceable(
                            onTap: () => controller.toggleWishlist(product),
                            child: !isFavorited
                                ? Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            product.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
