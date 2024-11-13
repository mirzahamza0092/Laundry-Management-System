import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/chargesProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
      GlobalKey<FormState> offerScreenKey=GlobalKey();
@override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chargerP =Provider.of<ChargesProvider>(context, listen: false);
        chargerP.getAllPrograms(context);
    });
      super.initState();
  }
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
          key:offerScreenKey ,
          child:provider.chargesChk?
          Center(child: CircularProgressIndicator(),):
          Column(
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
                commonText(text: "Add Offer  ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
              
              ],
            ),
            20.sh,
                commonText(text: "Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.offerName,
                  hinttext: "Offer Name",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Offer Name can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),10.sh,
          commonText(text: "Offer Percentage", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  keyboardType: TextInputType.number,
                  controller: provider.offerPer,
                  hinttext: "Percentage",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Percentage can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),10.sh,
          commonText(text: "Start Date", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                
          InkWell(
            onTap: (){
                provider.pickStartDateTime(context);
            },
            child: Container(
                  height: 50,
                        width: width(context),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(8),
                            color: AppColors.whiteColor),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonText(
                                  text:'${provider.startDate.year.toString()}-${provider.startDate.month.toString()}-${provider.startDate.day.toString()}  ${provider.startTime.hour.toString()}:${provider.startTime.minute.toString()}',
                                  size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.blackColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Image(image: AssetImage(ImagePath.calenderIcon), width: 50, height: 50)),
                                  ],
                                ),
                                            
                                    ),
                                      ) ,                                                  
                10.sh,
          commonText(text: "End Date", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                
          InkWell(
            onTap: (){
 provider.pickEndDateTime(context);
            },
            child: Container(
                  height: 50,
                        width: width(context),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(8),
                            color: AppColors.whiteColor),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonText(
                                text:'${provider.endedDate.year.toString()}-${provider.endedDate.month.toString()}-${provider.endedDate.day.toString()}  ${provider.endTime.hour.toString()}:${provider.endTime.minute.toString()}', 
                                size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.blackColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Image(image: AssetImage(ImagePath.calenderIcon), width: 50, height: 50)),
                                  ],
                                ),
                                            
                                    ),
                                      ),
                                            10.sh,
                        commonText(text: "Program", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                              10.sh,
                                    CommonDropDown(
                                                  color: AppColors.whiteColor,
                                                  width: width(context), 
                                                  selectedText: provider.programName.toString(), 
                                                  listItem: provider.programsList, 
                                                  onchanged: (val){
                                                  provider.programOnChange(val);
                                                }),
            20.sh,
              provider.addOfferChk?Center(child: CircularProgressIndicator()):CommonButton(onPressed: (){
          if(offerScreenKey.currentState!.validate()){
                provider.addOffer(context);
                  }
                }, width: width(context), text: "Submit",color: AppColors.primaryColor,)
          ]),
        ),
      );})
    ),
    );
  }
}