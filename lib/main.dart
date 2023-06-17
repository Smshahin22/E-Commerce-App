import 'package:e_commerce/ui/state_managers/auth_controller.dart';
import 'package:e_commerce/ui/state_managers/bottom_navigation_bar_controller.dart';
import 'package:e_commerce/ui/state_managers/cart_controller.dart';
import 'package:e_commerce/ui/state_managers/category_controller.dart';
import 'package:e_commerce/ui/state_managers/home_controller.dart';
import 'package:e_commerce/ui/state_managers/product_controller.dart';
import 'package:e_commerce/ui/state_managers/user_auth_controller.dart';
import 'package:e_commerce/ui/state_managers/user_profile_controller.dart';
import 'package:e_commerce/ui/state_managers/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/state_managers/remark_controller/new_product_by_remark_controller.dart';
import 'ui/state_managers/remark_controller/popular_by_remark_controller.dart';
import 'ui/state_managers/remark_controller/special_product_by_remark_controller.dart';

void main() {
  runApp(const CraftBay());
}

class CraftBay extends StatelessWidget {
  const CraftBay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetXBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0.1,
            titleTextStyle: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      home: const SplashScreen(),
      // theme: ThemeData(
      //   elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: primaryColor
      //
      //   )
      // ),
    );
  }
}

class GetXBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationBarController());
    Get.put(UserAuthController());
    Get.put(AuthController());
    Get.put(UserProfileController());
    Get.put(HomeController());
    Get.put(CategoryController());
    Get.put(PopularProductByRemarkController());
    Get.put(SpecialProductByRemarkController());
    Get.put(NewProductByRemarkController());
    Get.put(ProductController());
    Get.put(WishListController());
    Get.put(CartController());
  }
}
