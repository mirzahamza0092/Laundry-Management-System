import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

Widget commonFilterCard({
  required BuildContext context,
  required String image,
  required String title,
  required String button1Text,
  String? button2Text,
  String? distanceText,
  var button1Click,
  var button2Click,
}){

  return Container(
    width: width(context),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(12)
      
    ),
    child: Column(
      children: [
        Row(
          children: [
            Image(image:AssetImage(image),width: 100,height: 100,),
            Expanded(
              flex: 3,
              child: commonText(text: title, size: 14, color: AppColors.blackColor, fontweight: FontWeight.w700)),
            Spacer(),
            distanceText==null?SizedBox():
            commonText(text: 'Distance: $distanceText km', size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),10.sw
            
          ],
        ),       
      
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButton(onPressed: (){
              button1Click();
              }, 
              height: 50,
              width:button2Text==null? width(context)/1.4:width(context)/3, text:button1Text,color: AppColors.primaryColor, ),20.sw,
              button2Text==null?SizedBox():
              CommonButton(onPressed: (){
              button2Click();
              }, 
              height: 50,
              width: width(context)/3, text:button2Text,color: AppColors.redColor, ),
          
            ],
          ),20.sh,
      ],
    ),
  );
}