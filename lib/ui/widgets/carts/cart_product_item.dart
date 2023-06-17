import 'package:e_commerce/ui/state_managers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cart_list_model.dart';
import '../../utils/app_colors.dart';
import '../product_stepper.dart';

class CartProductItem extends StatefulWidget {
  CartProductItem({Key? key, required this.cartData}) : super(key: key);

  CartData cartData;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Visibility(
              visible: widget.cartData.product?.image != null,
              replacement: const SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    'No Image',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              child: Image.network(
                widget.cartData.product?.image ?? '',
                width: 120,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartData.product?.title ?? 'unknown ',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: greyColor),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'Size: ${widget.cartData.size}',
                                  style: const TextStyle(color: greyColor),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'Color: ${widget.cartData.color}',
                                  style: const TextStyle(color: greyColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_forever_outlined,
                            color: softGreyColor,
                          ))
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.cartData.product?.price ?? '0.0'}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProductStepper(
                          onDecrement: (int currentValue) {
                            Get.find<CartController>()
                                .decrementItem(widget.cartData.id!);
                          },
                          onIncrement: (int currentValue) {
                            Get.find<CartController>()
                                .incrementItem(widget.cartData.id!);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
