import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

Widget bookingCard({
  required BuildContext context,
  required String imag,
  required String delImag,
  required String title,
  required String subtitle,
  required String buttonText,
  required String counter,
  required Color counterColor,
  required var buttonClick,
  var delIconClick
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
            Image(image:AssetImage(imag),width: 100,height: 100,),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(text: title, size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),5.sh,
                  commonText(text: 'Type: $subtitle', size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),

                ],
              )),
            Spacer(),
            commonText(text: counter, size: 14, color: counterColor, fontweight: FontWeight.w400),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    delIconClick();
                  },
                  child:delImag.isEmpty?SizedBox(): Image(image:AssetImage(delImag),width: 50,height: 50,)),
              ],
            ),
            
          ],
        ),       
      
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButton(onPressed: (){
              buttonClick();
              }, 
              height: 50,
              width:width(context)/1.5, text:buttonText,color: AppColors.primaryColor, ),
            ],
          ),20.sh,
      ],
    ),
  );
}