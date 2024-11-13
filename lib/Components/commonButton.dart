import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/Colors.dart';

class CommonButton extends StatelessWidget {
  var onPressed;
  double width;
  double? height;
  String text;
  bool shadowneeded,gradientneeded;
  Color? color;
  Color textColor;
  CommonButton({
    required this.onPressed,
    required this.width,
    this.height,
    required this.text,
    this.color,
    this.textColor=Colors.white,
    this.shadowneeded = true,
  this.gradientneeded=true
    // super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
      decoration: BoxDecoration(
          boxShadow: shadowneeded
              ? [
                  BoxShadow(
                      color: AppColors.primaryColor,
                      offset: const Offset(1, 3),
                      blurRadius: 12,
                      spreadRadius: 0),
                  // BoxShadow(color: AppColors.primaryColor,offset:const Offset(0, 2),blurRadius: 10,spreadRadius: 0)
                ]
              : [],
          borderRadius: BorderRadius.circular(18),
        ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color,
              shadowColor: Colors.transparent,
              fixedSize: Size(width, 55.0)),
          child: commonText(
              text: text,
              fontweight: FontWeight.w600,
              size: 16.0,
              color: textColor)),
    );
  }
}