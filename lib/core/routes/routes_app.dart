import 'package:customer_order_app/core/routes/routes_name.dart';
import 'package:customer_order_app/presentation/views/auth/create_new_ps/create_new_ps_binding.dart';
import 'package:customer_order_app/presentation/views/auth/create_new_ps/create_new_ps_view.dart';
import 'package:customer_order_app/presentation/views/auth/forget_ps/forget_ps_binding.dart';
import 'package:customer_order_app/presentation/views/auth/forget_ps/forget_ps_view.dart';
import 'package:customer_order_app/presentation/views/auth/login/login_binding.dart';
import 'package:customer_order_app/presentation/views/auth/login/login_view.dart';
import 'package:customer_order_app/presentation/views/auth/onbording/onbording_binding.dart';
import 'package:customer_order_app/presentation/views/auth/onbording/onbording_view.dart';
import 'package:customer_order_app/presentation/views/auth/otp_forget_ps/otp_forget_ps_binding.dart';
import 'package:customer_order_app/presentation/views/auth/otp_forget_ps/otp_forget_ps_view.dart';
import 'package:customer_order_app/presentation/views/auth/otp_verify/otp_verify_binding.dart';
import 'package:customer_order_app/presentation/views/auth/otp_verify/otp_verify_view.dart';
import 'package:customer_order_app/presentation/views/auth/setup_account/setup_account_binding.dart';
import 'package:customer_order_app/presentation/views/auth/setup_account/setup_account_view.dart';
import 'package:customer_order_app/presentation/views/auth/signup/signup_binding.dart';
import 'package:customer_order_app/presentation/views/auth/signup/signup_view.dart';
import 'package:customer_order_app/presentation/views/auth/success_acc/success_acc_binding.dart';
import 'package:customer_order_app/presentation/views/auth/success_acc/success_acc_view.dart';
import 'package:customer_order_app/presentation/views/cart/cart_binding.dart';
import 'package:customer_order_app/presentation/views/cart/cart_view.dart';
import 'package:customer_order_app/presentation/views/home/detail_product/detail_product_binding.dart';
import 'package:customer_order_app/presentation/views/home/detail_product/detail_product_view.dart';
import 'package:customer_order_app/presentation/views/home/home_screen/home_binding.dart';
import 'package:customer_order_app/presentation/views/home/home_screen/home_view.dart';
import 'package:customer_order_app/presentation/views/main_screen/main_screen_binding.dart';
import 'package:customer_order_app/presentation/views/main_screen/main_screen_view.dart';
import 'package:customer_order_app/presentation/views/splash/splash_binding.dart';
import 'package:customer_order_app/presentation/views/splash/splash_view.dart';
import 'package:customer_order_app/presentation/views/wishlist/wishlist_binding.dart';
import 'package:customer_order_app/presentation/views/wishlist/wishlist_view.dart';
import 'package:get/route_manager.dart';

class RoutesApp {
  RoutesApp._();

  static final routesAppp = [
    GetPage(
      name: RoutesName.mainScreen,
      page: () => MainScreenView(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesName.productDetailScreen,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: RoutesName.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RoutesName.registerScreen,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: RoutesName.otpVerify,
      page: () => OtpVerifyView(),
      binding: OtpVerifyBinding(),
    ),
    GetPage(
      name: RoutesName.setUpAccount,
      page: () => SetupAccountView(),
      binding: SetupAccountBinding(),
    ),
    GetPage(
      name: RoutesName.successAcc,
      page: () => SuccessAccView(),
      binding: SuccessAccBinding(),
    ),
    GetPage(
      name: RoutesName.forgetPS,
      page: () => ForgetPsView(),
      binding: ForgetPsBinding(),
    ),
    GetPage(
      name: RoutesName.newPS,
      page: () => CreateNewPsView(),
      binding: CreateNewPsBinding(),
    ),
    GetPage(
      name: RoutesName.onBording,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: RoutesName.cartScreen,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: RoutesName.wishlist,
      page: () => WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: RoutesName.otpForgetPsVerify,
      page: () => OtpForgetPsView(),
      binding: OtpForgetPsBinding(),
    ),
  ];
}
