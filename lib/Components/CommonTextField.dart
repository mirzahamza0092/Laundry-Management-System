import 'package:flutter/material.dart';
import 'package:fyplms/Utils/Colors.dart';

class CommonTextField extends StatelessWidget {
  String? hinttext;
  bool obsecure, isEditable;
  final controller;
  var validator;
  Widget suffixicon;
  final TextInputType keyboardType;
  CommonTextField({
    this.controller,
    this.obsecure = false,
    this.validator,
    this.isEditable = true,
    this.suffixicon = const SizedBox(),
    this.hinttext,
    super.key,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        enabled: isEditable,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 24),
        // border: InputBorder.none,
        suffixIcon: suffixicon,
        hintText: hinttext,
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor),
        filled: true,
        fillColor: AppColors.whiteColor,
      ),
      textAlign: TextAlign.left,
    );
  }
}
