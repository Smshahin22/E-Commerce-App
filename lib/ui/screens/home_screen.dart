import 'package:e_commerce/ui/screens/bottom_nav_bar_screen.dart';
import 'package:e_commerce/ui/screens/complete_profile_screen.dart';
import 'package:e_commerce/ui/screens/profile_screen.dart';
import 'package:e_commerce/ui/state_managers/auth_controller.dart';
import 'package:e_commerce/ui/state_managers/bottom_navigation_bar_controller.dart';
import 'package:e_commerce/ui/state_managers/category_controller.dart';
import 'package:e_commerce/ui/state_managers/home_controller.dart';
import 'package:flutter/material.dart';
import '../state_managers/remark_controller/new_product_by_remark_controller.dart';
import '../state_managers/remark_controller/popular_by_remark_controller.dart';
import '../state_managers/remark_controller/special_product_by_remark_controller.dart';
import '../widgets/category_card_widget.dart';
import '../widgets/home/app_bar_icon_button.dart';
import '../widgets/home/home_carousel_widget.dart';
import 'package:get/get.dart';
import '../widgets/home/remarks-title_widget.dart';
import '../widgets/home/search_text_field.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Image.asset('assets/images/logo_nav.png'),
              const Spacer(),
              AppBarIconButton(
                onTap: () {
                  Get.find<AuthController>().isLoggedIn().then((value) {
                    if (value) {
                      Get.to(const ProfileScreen());
                    } else {
                      Get.to(const HomeScreen());
                    }
                  });
                },
                iconData: Icons.person,
              ),
              AppBarIconButton(
                onTap: () {
                  Get.find<AuthController>().isLoggedIn().then((value) {
                    if (value) {
                      Get.to(const CompleteProfileScreen());
                    } else {
                      Get.to(const HomeScreen());
                    }
                  });
                },
                iconData: Icons.call,
              ),
              AppBarIconButton(
                onTap: () {},
                iconData: Icons.notifications_outlined,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchTextField(),
                const SizedBox(height: 16),
                GetBuilder<HomeController>(builder: (homeController) {
                  if (homeController.getSliderInProgress) {
                    return const SizedBox(
                        height: 180,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return HomeCarouselWidget(
                    homeSliderModel: homeController.homeSliderModel,
                  );
                }),
                const SizedBox(height: 16),
                RemarksTitleWidget(
                  remarksName: "Categories",
                  onTapSeeAll: () {
                    Get.find<BottomNavigationBarController>().changeIndex(1);
                  },
                ),
                const SizedBox(height: 8),
                GetBuilder<CategoryController>(builder: (categoryController) {
                  if (categoryController.getCategoryInProgress) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: categoryController.categoryModel.categories!
                          .map((e) => CategoryCardWidget(
                                name: e.categoryName.toString(),
                                imageUrl: e.categoryImg.toString(),
                                id: e.id ?? 0,
                              ))
                          .toList(),
                    ),
                  );
                }),
                const SizedBox(height: 12),
                RemarksTitleWidget(
                  remarksName: "Popular",
                  onTapSeeAll: () {
                    Get.find<BottomNavigationBarController>().changeIndex(2);
                  },
                ),
                const SizedBox(height: 8),
                GetBuilder<PopularProductByRemarkController>(
                    builder: (productByRemarkController) {
                  if (productByRemarkController
                      .getPopularProductByRemarkInProgress) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: productByRemarkController
                          .popularProductsModel.products!
                          .map((product) => ProductCard(
                                product: product,
                              ))
                          .toList(),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                RemarksTitleWidget(
                  remarksName: "Special",
                  onTapSeeAll: () {},
                ),
                const SizedBox(height: 8),
                GetBuilder<SpecialProductByRemarkController>(
                    builder: (specialProductByRemarkController) {
                  if (specialProductByRemarkController
                      .getSpecialProductByRemarkInProgress) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: specialProductByRemarkController
                          .specialProductsModel.products!
                          .map((product) => ProductCard(
                                product: product,
                              ))
                          .toList(),
                    ),
                  );
                }),
                RemarksTitleWidget(
                  remarksName: "New",
                  onTapSeeAll: () {
                    Get.find<BottomNavigationBarController>().changeIndex(3);
                  },
                ),
                const SizedBox(height: 8),
                GetBuilder<NewProductByRemarkController>(
                    builder: (newProductByRemarkController) {
                  if (newProductByRemarkController
                      .getNewProductByRemarkInProgress) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: newProductByRemarkController
                          .newProductsModel.products!
                          .map((product) => ProductCard(
                                product: product,
                              ))
                          .toList(),
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
