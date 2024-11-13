import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

Widget commonProgrames ({
    required String title,
    required BuildContext context,
    String? subtitle,
    required String selectedText,
    required List<String> itemList,
    required var eyeOnClick,
    required var onChange,


}){
  return Container(
    width: width(context),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(12)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: Row(
          children: [
            commonText(text: title, size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
          subtitle==null?SizedBox():commonText(text: subtitle, size: 12, color: AppColors.blackColor, fontweight: FontWeight.w400),
            Spacer(),
            InkWell(
              onTap: eyeOnClick,
              child: Image(image:AssetImage(ImagePath.eyeIcon),width: 30,height: 30, ))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CommonDropDown(
          color: AppColors.backgroundColor,
          width: width(context), selectedText: selectedText, listItem: itemList, onchanged: (val){
          onChange(val);
        }),
      )
    ]),
  );
}