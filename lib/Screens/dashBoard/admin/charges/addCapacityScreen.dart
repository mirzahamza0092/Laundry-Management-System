import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/chargesProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class AddCapacityScreen extends StatefulWidget {
  const AddCapacityScreen({super.key});

  @override
  State<AddCapacityScreen> createState() => _AddCapacityScreenState();
}

class _AddCapacityScreenState extends State<AddCapacityScreen> {
      GlobalKey<FormState> addCapacityKey=GlobalKey();

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
      child:  Consumer<ChargesProvider>(builder: (context,provider,child){
                return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key:addCapacityKey ,
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
                commonText(text: "Add Machine Capacities  ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
              
              ],
            ),
            20.sh,
                commonText(text: "Capacity Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.cycleName,
                  hinttext: "Capacity Name",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Capacity Name can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Weight", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  keyboardType: TextInputType.number,
                  controller: provider.cycleWaterTemp,
                  hinttext: "Weight",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Weight can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Suit Quantity", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  keyboardType: TextInputType.number,
                  controller: provider.cycleDuration,
                  hinttext: "Suit Quantity",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Suit Quantity can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
              
                10.sh,
                commonText(text: "Price", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  keyboardType: TextInputType.number,
                  controller: provider.cyclePrice,
                  hinttext: "Price",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Price can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                                10.sh,
                commonText(text: "Type", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
            CommonDropDown(width: width(context), selectedText: provider.selectedMachineType.toString(), listItem:provider.machineType, onchanged: (val){
                        provider.cycleTypeChange(val);
                                      }),
                30.sh,
            provider.chargesChk?Center(child: CircularProgressIndicator()):CommonButton(onPressed: (){
          if(addCapacityKey.currentState!.validate()){
                provider.addCapacity(
                  provider.cycleName.text.toString(),
                  provider.selectedMachineType,
                  provider.cycleDuration.text.toString(),
                  provider.cycleWaterTemp.text.toString(),
                  provider.cyclePrice.text.toString(),
                  context);
                  }
                }, width: width(context), text: "Submit",color: AppColors.primaryColor,)
          ]),
        ),
      );})
    ),
    );
  }
}