import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';

class CommonAppBar extends StatelessWidget {
  String  title;
  CommonAppBar({
    this.title = "Welcome",
  });
  @override
  Widget build(BuildContext context) {
    return  AppBar(
        automaticallyImplyLeading: false,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
        toolbarHeight: 90,
        backgroundColor: AppColors.primaryColor,
        title: SafeArea(
          child: Row(
            children: [
              Container(
                width:80,
                height: 80,
                child: Image(image:AssetImage(ImagePath.appLogo))),
                commonText(text: title, size: 18, color: AppColors.whiteColor, fontweight: FontWeight.w500),
          Spacer(),
          Image(image:AssetImage(ImagePath.adminLogo),width: 70,height: 70,),
            ],
          ),
        ) ,
        );
  }
}