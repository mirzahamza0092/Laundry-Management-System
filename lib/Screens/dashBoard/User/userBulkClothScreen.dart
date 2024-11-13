import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/bulkRequestProvider.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class BulkBrachesScreen extends StatefulWidget {
  const BulkBrachesScreen({super.key});

  @override
  State<BulkBrachesScreen> createState() => _BulkBrachesScreenState();
}

class _BulkBrachesScreenState extends State<BulkBrachesScreen> {
        GlobalKey<FormState> bulkClothKey=GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bulkP =Provider.of<BulkRequestProvider>(context, listen: false);
    bulkP.getAllBranches(context);
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
                title: "User",
          ), 
    ),
      body: SafeArea(
        child: Consumer<BulkRequestProvider>(builder: (context,provider,child){
                return provider.bulkBookingChk?
                Center(
        child: CircularProgressIndicator(),
                ):
                Form(
        key: bulkClothKey,
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
                              commonText(text: "Available Branches", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                        
                                          ],
                                        ),
                            ),30.sh,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child:ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: AppConstants.bulkGetAllBranchesModel!.data.length,
                                    itemBuilder: (context,index){
                                      var data=AppConstants.bulkGetAllBranchesModel!.data[index];
                                      int distance=data.distance.toInt();
                                    return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: InkWell(
                                        child: Row(children: [
                                          commonText(text: "Branch Name: ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                          commonText(text: data.branchName.toString(), size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),Spacer(),
                                          commonText(text: "Distance: ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                          commonText(text: '${distance.toString()} Km', size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                          
                                        ]),
                                        onTap: (){
                                          showDialog(
                          context: context,
                          builder: (context1) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                actions: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText(text: "Request Name", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                                10.sh,
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: AppColors.blackColor),
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  child: CommonTextField(
                                                    controller: provider.rName,
                                                    hinttext: "Request Name",
                                                  validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Request Name can't be empty";
                                            } else {
                                              return null;
                                            }
                                          },),
                                                ),
                                                10.sh,
                                                commonText(text: "About Your Booking", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                                10.sh,
                                                Container(
                                        decoration: BoxDecoration(
                                                      border: Border.all(color: AppColors.blackColor),
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  child: CommonTextField(
                                                    controller: provider.rDescription,
                                                    hinttext: "Description",
                                                  validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Description can't be empty";
                                            } else {
                                              return null;
                                            }
                                          },),
                                                ),
                                                10.sh,
                                                10.sh,
                                                commonText(text: "Offer your fare", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                                10.sh,
                                                Container(
                                        decoration: BoxDecoration(
                                                      border: Border.all(color: AppColors.blackColor),
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  child: CommonTextField(
                                                    keyboardType: TextInputType.number,
                                                    controller: provider.rPrice,
                                                    hinttext: "Offer your fare",
                                                  validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Offer your fare can't be empty";
                                            } else {
                                              return null;
                                            }
                                          },),
                                                ),
                                                10.sh,
                                                commonText(text: "Date Time", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                                10.sh,
                                                
                                            Consumer<BulkRequestProvider>(builder: (context,bulkProvider,child){
                                                return    InkWell(
                                          onTap: (){
                                         bulkProvider.pickDateTime(context1);
                                          },
                                          child: Container(
                                                height: 50,
                                                      width: width(context1),
                                                      decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8),
                              color: AppColors.whiteColor),
                                                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: commonText(
                                    text:'${bulkProvider.selectedDate.year.toString()}-${bulkProvider.selectedDate.month.toString()}-${bulkProvider.selectedDate.day.toString()}  ${bulkProvider.selectedTime.hour.toString()}:${bulkProvider.selectedTime.minute.toString()}', 
                                    size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                                  ),
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
                                        );}),10.sh,
                                    provider.bulkBookingChk?Center(
                                      child: CircularProgressIndicator(),
                                    ):    CommonButton(onPressed: (){
                                          provider.requestBulkCloth(
                                            provider.rName.text.toString(),
                                            provider.rDescription.text.toString(),
                                            provider.rPrice.text.toString(),
                                            data.branchId.toString(),
                                            provider.dateTimes.toString(),
                                            context1,
                                          );
                                        }, width: width(context), text: "Request Now",color: AppColors.primaryColor,)
                                  ],
                                ),]
                              ),
                            );});
                                        },
                                      ),
                                    ),
                                  ),
                                  10.sh,
                                  ],
                              );})
                            )
              ],
            ),
        ),
                );}),
      ),
    );
  }
}