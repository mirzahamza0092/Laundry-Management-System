import 'package:flutter/material.dart';
import 'package:fyplms/Utils/Colors.dart';

class commonSearchBar extends StatelessWidget {
  final controller;
  var onvaluechange;
  commonSearchBar(
      {super.key, required this.controller, required this.onvaluechange});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onvaluechange,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon:const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0.15,
            color: AppColors.blackColor.withOpacity(.25),
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 20),
        // border: InputBorder.none,
        hintText: "Search",
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
