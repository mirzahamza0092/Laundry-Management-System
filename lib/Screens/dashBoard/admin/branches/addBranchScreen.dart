import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class addBranchScreen extends StatefulWidget {
  const addBranchScreen({super.key});

  @override
  State<addBranchScreen> createState() => _addBranchScreenState();
}

class _addBranchScreenState extends State<addBranchScreen> {
      GlobalKey<FormState> addbranchesKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:  CommonAppBar(
                title: "Admin",
          ), 
    ),
    body: SingleChildScrollView(
      child:  Consumer<branchesProvider>(builder: (context,provider,child){
                return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key:addbranchesKey ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.sh,
            Row(
              children: [
                InkWell(
                  onTap: (){
                    provider.clearInputData();
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => dashBoardScreen()),
          );
                  },
                  child: Icon(Icons.arrow_back_outlined)),12.sw,
                commonText(text: "Add Branch  ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
              
              ],
            ),
            20.sh,
                commonText(text: "Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.branchName,
                  hinttext: "Name",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Name can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Latitude", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  keyboardType: TextInputType.number,
                  controller: provider.branchLatitude,
                  hinttext: "Latitude",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Latitude can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Longitude", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  keyboardType: TextInputType.number,
                  controller:provider.branchLongitude ,
                  hinttext: "Longitude",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Longitude can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                
                30.sh,
            provider.addBranchChk?Center(child: CircularProgressIndicator()):CommonButton(onPressed: (){
          if(addbranchesKey.currentState!.validate()){
                provider.addBranches(
                  provider.branchName.text.toString(),provider.branchLatitude.text.toString(),provider.branchLongitude.text.toString(),context);
                  }
                }, width: width(context), text: "Submit",color: AppColors.primaryColor,)
          ]),
        ),
      );})
    ),
    );
  }
}