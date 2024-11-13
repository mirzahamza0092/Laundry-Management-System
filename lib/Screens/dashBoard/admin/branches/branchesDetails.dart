import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/branches/allBranchScreen.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class branchDetailScreen extends StatefulWidget {
  const branchDetailScreen({super.key});

  @override
  State<branchDetailScreen> createState() => _branchDetailScreenState();
}

class _branchDetailScreenState extends State<branchDetailScreen> {
        GlobalKey<FormState> updateBranchesKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.backgroundColor,
    body: SafeArea(
      child: SingleChildScrollView(
        child:  Consumer<branchesProvider>(builder: (context,provider,child){
                  return Container(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 20),
          child: Form(
            key: updateBranchesKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.sh,
              InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => allBranchScreen()),
                        );
                },
                child: Icon(Icons.arrow_back_outlined)),
                12.sw,
                Center(child: Image(image:AssetImage(ImagePath.appLogo),width: 100,height: 100,)),
              Center(child: commonText(text:provider.getspecificChk? "Branch Details":"Update Branch", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500)),
              20.sh,
            
                  commonText(text: "Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  10.sh,
                  CommonTextField(
                    controller: provider.branchName,
                    isEditable:provider.getspecificChk?false:true,
                    hinttext: provider.specificBranch!.name.toString(),
                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Name can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                ),
                  10.sh,
                  commonText(text: "Latitude", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  10.sh,
                  CommonTextField(
                    controller: provider.branchLatitude, 
                    isEditable: provider.getspecificChk?false:true,
                    hinttext: provider.specificBranch!.latitude.toString(),
                  validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Latitude can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
            
                ),
                  10.sh,
                  commonText(text: "Longitude", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  10.sh,
                  CommonTextField(
                    controller:provider.branchLongitude ,
                    isEditable: provider.getspecificChk?false:true,
                    hinttext: provider.specificBranch!.longitude.toString(),
            validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Longitude can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                  ),
                  10.sh,
                provider.getspecificChk?SizedBox():provider.addBranchChk?
                Center(child: CircularProgressIndicator(),): CommonButton(onPressed: (){
            if(updateBranchesKey.currentState!.validate()){
                  provider.updateSpecificBranch(provider.specificBranch!.id.toString(), provider.branchName.text.toString(), provider.branchLatitude.text.toString(),provider.branchLongitude.text.toString(), context);
                  }
                  }, width: width(context), text: "Update",color: AppColors.primaryColor,),20.sh
            ]),
          ),
        );})
      ),
    ),
    );
  }
}