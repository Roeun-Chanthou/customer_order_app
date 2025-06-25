import 'package:customer_order_app/core/routes/routes_app.dart';
import 'package:customer_order_app/presentation/views/main_screen/main_screen_binding.dart';
import 'package:customer_order_app/presentation/views/main_screen/main_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: RoutesName.splash,
      home: MainScreenView(),
      defaultTransition: Transition.fadeIn,
      getPages: RoutesApp.routesAppp,
      initialBinding: MainScreenBinding(),
    );
  }
}
