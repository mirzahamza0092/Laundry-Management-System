import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

Widget commonCard({
  required BuildContext context,
  required String imag,
  required String title,
  required String button1Text,
  String? button2Text,title1,title2,title3,
  bool detailChk=false,
  bool delIconChk=false,
  bool imgChk=false,
  Color? color=const Color(0XFF1971c2),
  var button1Click,
  var button2Click,
  var editIconClick,
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
          imgChk? 
          Image.network(imag,width: 100,height: 100,):
          Image(image:AssetImage(imag),width: 100,height: 100,),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(text: title, size: 14, color: AppColors.blackColor, fontweight: FontWeight.w700),
                detailChk? Column(
                    children: [
                      5.sh,
                  commonText(text: title1, size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  commonText(text: title2, size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  commonText(text: title3, size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),

                    ],
                  ):SizedBox()
                ],
              )),
            Spacer(),
            Row(
              children: [
              editIconClick==null?SizedBox():  InkWell(
                  onTap: (){
                    editIconClick();
                  },
                  child: Image(image:AssetImage(ImagePath.updateIcon),width: 50,height: 50,)),
              delIconChk? InkWell(
                  onTap: (){
                    delIconClick();
                  },
                  child: Image(image:AssetImage(ImagePath.delIcon),width: 50,height: 50,)):SizedBox(),
              ],
            ),
            
          ],
        ),       
      
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButton(onPressed: (){
              button1Click();
              }, 
              height: 50,
              width:button2Text==null? width(context)/1.4:width(context)/3, text:button1Text,color: color, ),20.sw,
              button2Text==null?SizedBox():
              CommonButton(onPressed: (){
              button2Click();
              }, 
              height: 50,
              width: width(context)/3, text:button2Text,color: AppColors.primaryColor, ),
          
            ],
          ),20.sh,
      ],
    ),
  );
}