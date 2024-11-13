import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonCard.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Screens/dashBoard/admin/branches/addBranchScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/charges/addCapacityScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/charges/addCycleScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/charges/chargesScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/offers/allOffers.dart';
import 'package:fyplms/Screens/dashBoard/admin/offers/offerScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/shopkeepers/addShopkeeperScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/branches/allBranchScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/shopkeepers/allShopKeepers.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';

class dashBoardScreen extends StatefulWidget {
  const dashBoardScreen({super.key});

  @override
  State<dashBoardScreen> createState() => _dashBoardScreenState();
}

class _dashBoardScreenState extends State<dashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:AppConstants.loginSModel!.role=="User"?SizedBox():  CommonAppBar(
                title:AppConstants.loginSModel!.role=="Admin"? "Admin":AppConstants.loginSModel!.role=="User"?"User":"Retailer",
          ), 
    ),
    body:SingleChildScrollView(
      child:Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            20.sh,
            Container(
              alignment: Alignment.bottomRight,
              child: CommonButton(onPressed: (){
                Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>LoginScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Logout Successfully")); 
              },text: "Logout !",width: width(context)/2,color: AppColors.primaryColor,height: 50,)),
            
              20.sh,
              commonCard(
              imag: ImagePath.branchIcon,
              title: "Branch ",
              button1Text: "Add",
              button2Text: "All",
              context: context,
              button1Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addBranchScreen()),);
              
              },
              button2Click: (){
                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => allBranchScreen()),
            );
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (context) => allBranchScreen()),);
              }
              ),
              
              30.sh,
            commonCard(
              imag: ImagePath.userLogo,
              title: "Retailer",
              button1Text: "Add",
              button2Text: "All",
              button1Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addShopKeeperScreen()),
            );
            
              },
              button2Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => allShopKeepers()),
            );
                // Navigator.of(context).pushReplacement(
                // MaterialPageRoute(builder: (context) => allShopKeepers()),);
              },
              context: context),
              30.sh,
              commonCard(
              imag: ImagePath.chargesIcon,
              title: "Charges Managment ",
              button1Text: "Add",
              button1Click: (){
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                    title:commonText(text: "What you want to add ?", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  actions: <Widget>[
                    CommonButton(onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCycleScreen()),);

                    }, width: width(context)/3, text: "Program",color: AppColors.primaryColor,height: 40,),
                    CommonButton(onPressed: (){
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCapacityScreen()),);
                    }, width: width(context)/3, text: "Capacity",color: AppColors.primaryColor,height: 40),

                    ],
                  );
                },);   
              
              },
              button2Text: "Update",
              button2Click: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => chargesScreen()),);
              },
              context: context),
              30.sh,
            commonCard(
              imag: ImagePath.offerIcon,
              title: "Offers",
              button1Text: "Add",
              button2Text: "All",
              button1Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OfferScreen()),
            );
            
              },
              button2Click: (){
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminOfferScreen()),
            );
              },
              context: context),30.sh
          ],
        ))
    ) ,
    );
  }
}