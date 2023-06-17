import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/product_list_screen.dart';
import '../utils/app_colors.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);

  final String name, imageUrl;
  final int id;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          Get.to(ProductListScreen(
            categoryId: id,
          ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      imageUrl,
                      height: 40,
                      width: 40,
                      fit: BoxFit.scaleDown,
                    )),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  letterSpacing: 0.6,
                  fontSize: 13,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
