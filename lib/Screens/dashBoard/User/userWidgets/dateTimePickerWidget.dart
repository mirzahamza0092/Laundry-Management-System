import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

Widget dateTimePickerWidget({
  required String text,
  required String image,
  required var onClick,
  required BuildContext context
}){
  return InkWell(
    onTap: onClick,
    child: Container(
          height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(8),
                    color: AppColors.whiteColor),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(8),
                            color: AppColors.whiteColor),
                        padding: const EdgeInsets.all(16),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                          commonText(text: text, size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400)
                          ],
                        )),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blackColor),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Image(image: AssetImage(image), width: 50, height: 50)),
                          ],
                        ),
                                    
                            ),
  );
}
