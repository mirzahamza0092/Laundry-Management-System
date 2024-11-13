import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonCard.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/allBookingsScreen.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/machine/addMachineScreen.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/machine/allMachineScreen.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/products/addProductScreen.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/products/allProductsScreen.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

class RetailerDashboard extends StatefulWidget {
  const RetailerDashboard({super.key});

  @override
  State<RetailerDashboard> createState() => _RetailerDashboardState();
}

class _RetailerDashboardState extends State<RetailerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:AppConstants.loginSModel!.role=="User"?SizedBox():  CommonAppBar(
                title:AppConstants.loginSModel!.role=="Admin"? "Admin":AppConstants.loginSModel!.role=="User"?"User":"Laundry Manager",
          ), 
    ),
    body: SingleChildScrollView(
      child:Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            20.sh,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllBookingsScreen()),);
                },text: "All Bookings",width: width(context)/2.5,color: AppColors.primaryColor,height: 40,),
              //   InkWell(
              //     onTap: (){
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => AllBookingsScreen()),);
              //     },
              //     child: commonText(text: "All Bookings", size: 18, color: AppColors.primaryColor, fontweight: FontWeight.w600)),
                commonText(text: "|", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w900),
                // InkWell(
                //   onTap: (){
                    
                //   },
                //   child: commonText(text: "Add Offer", size: 18, color: AppColors.primaryColor, fontweight: FontWeight.w600)),
                // commonText(text: "|", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w900),
                // InkWell(
                //   onTap: (){
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) =>LoginScreen()),
                //   );
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       appSnackBar("Logout Successfully")); 
                //   },
                //   child: commonText(text: "Logout ?", size: 18, color: AppColors.primaryColor, fontweight: FontWeight.w600)),
        CommonButton(onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) =>LoginScreen()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Logout Successfully")); 
                },text: "Logout ?",width: width(context)/2.5,color: AppColors.primaryColor,height: 40,),
              
              ],
            ),
            20.sh,
            commonCard(
              imag: ImagePath.washingMachineIcon,
              title: "Machines",
              button1Text: "Add",
              button2Text: "All",
              button1Click: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddMachineScreen()),);
              },
              button2Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllMachineScreen()),);
              },
              context: context),
              30.sh,
              commonCard(
              imag: ImagePath.itemIcon,
              title: "Products",
              button1Text: "Add",
              button2Text: "All",
              context: context,
              button1Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductScreen()),);
              },
              button2Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllProductsScreen()),);
              }
              ),
              
          ],
        ))
    ) ,
    );
  }
}