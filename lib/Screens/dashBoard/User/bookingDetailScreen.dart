import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/userDashboardProvider.dart';
import 'package:fyplms/Screens/dashBoard/User/findLaundryScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Screens/dashBoard/User/userWidgets/commonTextBox.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class bookingDetailScreen extends StatefulWidget {
  const bookingDetailScreen({super.key});

  @override
  State<bookingDetailScreen> createState() => _bookingDetailScreenState();
}

class _bookingDetailScreenState extends State<bookingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child:Consumer<UserDashbardProvider>(builder: (context,provider,child){
                return  SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                20.sh,
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => findLaundryScreen()),
                          );
                    },
                    child: Icon(Icons.arrow_back_outlined)),12.sw,
                  commonText(text: "Booking Details", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
                              ],
                ),
                20.sh,
                Image(image:AssetImage(ImagePath.appLogo),width: 100,height: 100,),
                20.sh,
                commonTextBox(context: context, text1: "Time:", text2: AppConstants.userGetAllMachinesModel!.data.machinesList[0].bookingDate.toString()),
                20.sh,
                commonTextBox(context: context, text1: "Programs:", text2: '${provider.selectedCycle},${provider.limitText=="2" ||provider.limitText=="3"? provider.selectedCycle2:""},${provider.limitText=="3"? provider.selectedCycle3:""}'),
                20.sh,
                commonTextBox(context: context, text1: "Detergents:", text2: provider.allProductsString),
                20.sh,
                commonTextBox(context: context, text1: "Capacity:", text2: '${provider.selectedCapacity},${provider.limitText=="2" ||provider.limitText=="3"? provider.selectedCapacity2:""},${provider.limitText=="3"? provider.selectedCapacity3:""}'),
                20.sh,
                commonTextBox(context: context, text1: "Machine Type:", text2:provider.machinesChk?"Washer":"Dryer"),
                20.sh,
                commonTextBox(context: context, text1: "Cycle:", text2: provider.round.toString()),
                20.sh,
                commonTextBox(context: context, text1: "Distance:", text2: provider.distance.toString()),
                20.sh,
                commonTextBox(context: context, text1: "Total Bill:", text2: '${AppConstants.userGetAllMachinesModel!.data.price} Rs | After Disc:${AppConstants.userGetAllMachinesModel!.data.discountedPrice} Rs '),
                20.sh,
                commonTextBox(context: context, text1: "Branch:", text2: provider.branchName),
                20.sh,
            provider.dryerYesOrNoChk?Center(
              child: CircularProgressIndicator(),
            ):
                CommonButton(onPressed: (){
                  if(provider.machinesChk==false){
                    provider.bookingDoneCall(context,false);
                  }else{
            showDialog(
              context: context,
              builder: (BuildContext context1) {
                return AlertDialog(
                  icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                  content: Text("You also want Dryer ?"),
                  actions: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonButton(onPressed: (){
                          Navigator.of(context).pop();
                      provider.bookingDoneCall(context,true);
                          }, width: width(context)/4, text: "Yes",color: AppColors.primaryColor,height: 50),
                          CommonButton(onPressed: (){
                          Navigator.of(context).pop();
                      provider.bookingDoneCall(context,false);
                          }, width: width(context)/4, text: "No",color: AppColors.primaryColor,height: 50),
                        ],
                      ),
                    ),
                    
                  ],
                );
              },
            );}
          }, width: width(context), text: "Book Now",color: AppColors.primaryColor,),
                20.sh,
              ],
            ),
          ),
        );})
      ),
    );
  }
}