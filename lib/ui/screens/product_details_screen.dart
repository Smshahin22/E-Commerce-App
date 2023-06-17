import 'package:e_commerce/ui/state_managers/auth_controller.dart';
import 'package:e_commerce/ui/state_managers/cart_controller.dart';
import 'package:e_commerce/ui/state_managers/product_controller.dart';
import 'package:e_commerce/ui/state_managers/wish_list_controller.dart';
import 'package:e_commerce/ui/utils/styles.dart';
import 'package:e_commerce/ui/widgets/common_elevated_button.dart';
import 'package:e_commerce/ui/widgets/product_details/product_image_carousel.dart';
import 'package:e_commerce/ui/widgets/product_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<Color> colors = [];
  List<String> sizes = [];

  Color? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductController>().getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: const BackButton(color: Colors.grey),
      ),
      body: GetBuilder<ProductController>(
          builder: (productController) {
        if (productController.getProductDetailsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final productDetails =
            productController.productDetailsModel.data!.first;
        colors = getColors(productDetails.color ?? '');
        sizes = getSize(productDetails.size ?? '');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImageCarousel(
                      images: [
                        productDetails.img1 ?? '',
                        productDetails.img2 ?? '',
                        productDetails.img3 ?? '',
                        productDetails.img4 ?? '',
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        productDetails.product?.title ??
                                            'unknown',
                                        style: titleTextStyle.copyWith(
                                          fontSize: 16,
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 5),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.star,
                                                color: Colors.amber, size: 14),
                                            Text(
                                              '${productDetails.product?.star ?? 0}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: softGreyColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 4),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Reviews',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        GetBuilder<WishListController>(
                                            builder: (wishListController) {
                                          if (wishListController
                                              .addNewItemInProgress) {
                                            return const CircularProgressIndicator();
                                          }
                                          return InkWell(
                                            onTap: () {
                                              Get.find<WishListController>()
                                                  .addToWishList(productDetails
                                                      .productId!);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              ProductStepper(
                                onDecrement: (int currentValue) {},
                                onIncrement: (int currentValue) {},
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Color',
                            style: TextStyle(
                              fontSize: 20,
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: colors.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  if (_selectedColor != e) {
                                    _selectedColor = e;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: e,
                                  radius: 16,
                                  child: Visibility(
                                      visible: e == _selectedColor,
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            );
                          }).toList()),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 20,
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                              children: sizes.map((size) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  if (_selectedSize != size) {
                                    _selectedSize = size;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: greyColor),
                                      borderRadius: BorderRadius.circular(6),
                                      color: size == _selectedSize
                                          ? primaryColor
                                          : null,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: size == _selectedSize
                                                ? Colors.white
                                                : null),
                                      ),
                                    )),
                              ),
                            );
                          }).toList()),
                          const SizedBox(height: 10),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            productDetails.product?.shortDes ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: softGreyColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: softGreyColor),
                        ),
                        Text(
                          '\$${productDetails.product?.price ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 120,
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        if (cartController.addToCartInProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return CommonElevatedButton(
                          onTap: () async {
                            final result = await Get.find<AuthController>()
                                .checkAuthValidition();
                            if (result) {
                              if (_selectedSize != null &&
                                  _selectedColor != null) {
                                Get.find<CartController>()
                                    .addToCart(
                                        productDetails.product!.id!,
                                        _selectedSize!,
                                        _getHexCode(_selectedColor!))
                                    .then((value) {
                                  if (value) {
                                    Get.showSnackbar(const GetSnackBar(
                                      title: 'Success',
                                      message: 'Added to cart!',
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                });
                              } else {
                                Get.showSnackbar(const GetSnackBar(
                                  title: 'Select color and size',
                                  message:
                                      'You have to select color and size both',
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            }
                          },
                          title: 'Add to cart',
                        );
                      }),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  List<String> getSize(String size) {
    return size.split(',');
  }

  List<Color> getColors(String color) {
    List<Color> hexColors = [];
    List<String> colors = color.split(',');
    for (String c in colors) {
      c = c.replaceAll('#', '0xFF');
      hexColors.add(Color(int.parse(c)));
    }
    return hexColors;
  }

  String _getHexCode(Color color) {
    return color.toString
        .toString()
        .replaceAll('0xff', '#')
        .replaceAll('Color(', '')
        .replaceAll(')', '');
  }
}
