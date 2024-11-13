import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

Widget commonTextBox({
required BuildContext context,
required String text1,
required String text2,
}){
  return Container(
    width: width(context),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(12)
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: Row(
        children: [
          commonText(text: text1, size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
          Expanded(child: commonText(text: text2, size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400)),
      
        ],
      ),
    ),
  );
}