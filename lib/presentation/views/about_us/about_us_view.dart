import 'package:customer_order_app/core/themes/themes.dart';
import 'package:customer_order_app/presentation/views/about_us/about_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemesApp.primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: ThemesApp.primaryColor,
        title: const Text(
          'Meet Our Team',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              'We are passionate about building great products.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
                children: [
                  _buildMemberCard(
                    imageUrl: 'assets/aboutus/me.jpg',
                    name: 'Roeun Chanthou',
                    position: 'Mobile Developer',
                  ),
                  _buildMemberCard(
                    imageUrl: 'assets/aboutus/kimlong.jpg',
                    name: 'Ieng Kimlong',
                    position: 'Mobile Developer',
                  ),
                  _buildMemberCard(
                    imageUrl: 'assets/aboutus/kimlong.jpg',
                    name: 'Ren Rady',
                    position: 'Mobile Developer',
                  ),
                  _buildMemberCard(
                    imageUrl: 'assets/aboutus/kimlong.jpg',
                    name: 'Em Sokhai',
                    position: 'Mobile Developer',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard({
    required String imageUrl,
    required String name,
    required String position,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
            radius: 50,
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            position,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
