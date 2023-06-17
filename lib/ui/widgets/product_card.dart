import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    this.onRemove,
  }) : super(key: key);

  final Product product;
  final Function? onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 140,
          child: InkWell(
            onTap: () {
              Get.to(ProductDetailsScreen(
                productId: product.id!,
              ));
            },
            borderRadius: BorderRadius.circular(10),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.zero,
              shadowColor: primaryColor.withOpacity(0.2),
              child: Column(
                children: [
                  Image.network(
                    product.image ?? "",
                    width: 130,
                    height: 90,
                    fit: BoxFit.scaleDown,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          product.title ?? 'unknown',
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.3,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 14),
                                Text(
                                  '${product.star ?? 0}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: softGreyColor,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: onRemove != null,
          child: Positioned(
            right: 0,
            top: 2,
            child: IconButton(
                onPressed: () {
                  onRemove!();
                },
                icon: const CircleAvatar(
                  backgroundColor: greyColor,
                  radius: 14,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 15,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
