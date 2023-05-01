import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.textInputType,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String?) validator;
  final String hintText;
  final TextInputType? textInputType;
  final  int? maxLines;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLines,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              color: greyColor
          ),
          contentPadding: const EdgeInsets.all(16),

          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor,width: 2)
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2)
          )

      ),
    );
  }
}


