import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

class meScreen extends StatefulWidget {
  const meScreen({super.key});

  @override
  State<meScreen> createState() => _meScreenState();
}

class _meScreenState extends State<meScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:  CommonAppBar(
                title: "User",
          ), 
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                            Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => userDashboardScreen()),
                                    );
                              },
                              child: Icon(Icons.arrow_back_outlined)),12.sw,
                            commonText(text: "Me", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                        Spacer(),
                                        CommonButton(
                                          onPressed: (){
                                          Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) =>LoginScreen()),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(
                                                        appSnackBar("Logout Successfully")); 
                                        }, width: width(context)/3, text: "Logout",color: AppColors.primaryColor,),
                                        ],
                                      ),
                          ),30.sh,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonText(text: "Name", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                10.sh,
                                CommonTextField(hinttext: "Name",),
                                10.sh,
                                commonText(text: "Phone Number", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                10.sh,
                                CommonTextField(
                                  hinttext: "Phone Number",
                                  keyboardType: TextInputType.number,
                                  ),
                                  30.sh,
                                  CommonButton(onPressed: (){}, width: width(context), text: "Change",color: AppColors.primaryColor,)
                              ],
                            ),
                          )
            ],
          ),
        ),
      ),
    );
  }
}