import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/chargesProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class chargesScreen extends StatefulWidget {
  const chargesScreen({super.key});

  @override
  State<chargesScreen> createState() => _chargesScreenState();
}

class _chargesScreenState extends State<chargesScreen> {
  @override
  void initState() {
    var chargesP = Provider.of<ChargesProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
    chargesP.getAllPrograms(context);
    chargesP.getAllLoadCapacity(context);
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
      child:Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Consumer<ChargesProvider>(builder: (context,provider,child){
                return provider.chargesChk?Center(child:CircularProgressIndicator(),): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              commonText(text: "Manage Charges", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
            ],
          ), 
          20.sh,
          Row(
            children: [
              commonText(text: "Washer Program ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              Spacer(),
              commonText(text: "Price ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              ],),5.sh,
          ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          itemCount: AppConstants.getAllProgramModel!.data.length,
            itemBuilder: (context,index){
              return AppConstants.getAllProgramModel!.data[index].type=="Washer"?
              Column(
                children: [
                  InkWell(
                    onLongPress: (){
                      provider.updatePriceDialog(AppConstants.getAllProgramModel!.data[index].price.toString());
                      showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                    title:commonText(text: "Update Price", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  actions: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        keyboardType: TextInputType.number,
                        controller:provider.cyclePrice ,
                      ),
                    ),
                    10.sh,
                    Center(
                      child: CommonButton(onPressed: (){
                        provider.updateProgram(
                          AppConstants.getAllProgramModel!.data[index].id.toString(), 
                          AppConstants.getAllProgramModel!.data[index].name.toString(), 
                          AppConstants.getAllProgramModel!.data[index].type.toString(),
                          AppConstants.getAllProgramModel!.data[index].duration.toString(),
                          AppConstants.getAllProgramModel!.data[index].spinSpeed.toString(),
                          AppConstants.getAllProgramModel!.data[index].temprature.toString(),
                          provider.cyclePrice.text.toString(),
                          context);
                      }, width: width(context)/2, text: "Update",color: AppColors.primaryColor,),
                    )
                    ],
                  );
                },); 
                    },
                    child: Container(
                    width: width(context),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                              Row(
                            children: [
                              commonText(text: AppConstants.getAllProgramModel!.data[index].name.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
                                    commonText(text: AppConstants.getAllProgramModel!.data[index].price.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400)
                              
                              ),
                              ],),5.sh,
                              
                        ],
                      ),
                    )),
                  ),10.sh,
                ],
              ):SizedBox();}
          ),
          10.sh,
          Row(
            children: [
              commonText(text: "Dryer Program ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              Spacer(),
              commonText(text: "Price ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              ],),5.sh,
          ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          itemCount: AppConstants.getAllProgramModel!.data.length,
            itemBuilder: (context,index){
              return AppConstants.getAllProgramModel!.data[index].type=="Dryer"?
              Column(
                children: [
                  InkWell(
                    onLongPress: (){
                      provider.updatePriceDialog(AppConstants.getAllProgramModel!.data[index].price.toString());
                      showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                    title:commonText(text: "Update Price", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  actions: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        keyboardType: TextInputType.number,
                        controller:provider.cyclePrice ,
                      ),
                    ),
                    10.sh,
                    Center(
                      child: CommonButton(onPressed: (){
                      provider.updateProgram(
                          AppConstants.getAllProgramModel!.data[index].id.toString(), 
                          AppConstants.getAllProgramModel!.data[index].name.toString(), 
                          AppConstants.getAllProgramModel!.data[index].type.toString(),
                          AppConstants.getAllProgramModel!.data[index].duration.toString(),
                          AppConstants.getAllProgramModel!.data[index].spinSpeed.toString(),
                          AppConstants.getAllProgramModel!.data[index].temprature.toString(),
                          provider.cyclePrice.text.toString(),
                          context);
                          Navigator.of(context).pop();
                      }, width: width(context)/2, text: "Update",color: AppColors.primaryColor,),
                    )
                    ],
                  );
                },); 
                    },
                    child: Container(
                    width: width(context),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                              Row(
                            children: [
                              commonText(text: AppConstants.getAllProgramModel!.data[index].name.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
                                    commonText(text: AppConstants.getAllProgramModel!.data[index].price.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400)
                              
                              ),
                              ],),5.sh,
                              
                        ],
                      ),
                    )),
                  ),10.sh,
                ],
              ):SizedBox();}
          ),
          10.sh,
          Row(
            children: [
              commonText(text: "Washer Load Capacity ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              Spacer(),
              commonText(text: "Price ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              ],),5.sh,
              ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          itemCount: AppConstants.getAllLoadCapacityModel!.data.length,
            itemBuilder: (context,index){
              return AppConstants.getAllLoadCapacityModel!.data[index].type=="Washer"?
              Column(
                children: [
                  InkWell(
                    onLongPress: (){
                      provider.updatePriceDialog(AppConstants.getAllLoadCapacityModel!.data[index].price.toString());
                      showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                    title:commonText(text: "Update Price", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  actions: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        keyboardType: TextInputType.number,
                        controller:provider.cyclePrice ,
                      ),
                    ),
                    10.sh,
                    Center(
                      child: CommonButton(onPressed: (){
                      provider.updateLoadCapacity(
                          AppConstants.getAllLoadCapacityModel!.data[index].id.toString(), 
                          AppConstants.getAllLoadCapacityModel!.data[index].name.toString(),
                          provider.cyclePrice.text.toString(),
                          context);
                          Navigator.of(context).pop();
                      }, width: width(context)/2, text: "Update",color: AppColors.primaryColor,),
                    )
                    ],
                  );
                },); 
                    },
                    child: Container(
                    width: width(context),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                              Row(
                            children: [
                              commonText(text: AppConstants.getAllLoadCapacityModel!.data[index].name.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
                                    commonText(text: AppConstants.getAllLoadCapacityModel!.data[index].price.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400)
                              
                              ),
                              ],),5.sh,
                              
                        ],
                      ),
                    )),
                  ),10.sh,
                ],
              ):SizedBox();}
          ),
          
          10.sh,
          Row(
            children: [
              commonText(text: "Dryer Load Capacity ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              Spacer(),
              commonText(text: "Price ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
              ],),5.sh,
              ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          itemCount: AppConstants.getAllLoadCapacityModel!.data.length,
            itemBuilder: (context,index){
              return AppConstants.getAllLoadCapacityModel!.data[index].type=="Dryer"?
              Column(
                children: [
                  InkWell(
                    onLongPress: (){
                      provider.updatePriceDialog(AppConstants.getAllLoadCapacityModel!.data[index].price.toString());
                      showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                    title:commonText(text: "Update Price", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  actions: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        keyboardType: TextInputType.number,
                        controller:provider.cyclePrice ,
                      ),
                    ),
                    10.sh,
                    Center(
                      child: CommonButton(onPressed: (){
                      provider.updateLoadCapacity(
                          AppConstants.getAllLoadCapacityModel!.data[index].id.toString(), 
                          AppConstants.getAllLoadCapacityModel!.data[index].name.toString(),
                          provider.cyclePrice.text.toString(),
                          context);
                          Navigator.of(context).pop();
                      }, width: width(context)/2, text: "Update",color: AppColors.primaryColor,),
                    )
                    ],
                  );
                },); 
                    },
                    child: Container(
                    width: width(context),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                              Row(
                            children: [
                              commonText(text: AppConstants.getAllLoadCapacityModel!.data[index].name.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
                                    commonText(text: AppConstants.getAllLoadCapacityModel!.data[index].price.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400)
                              
                              ),
                              ],),5.sh,
                              
                        ],
                      ),
                    )),
                  ),10.sh,
                ],
              ):SizedBox();}
          ),
        ],
      );}))),
    );
  }
}