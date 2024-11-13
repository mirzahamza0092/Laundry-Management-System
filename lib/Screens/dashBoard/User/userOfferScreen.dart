import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/userOfferProvider.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class userOfferScreen extends StatefulWidget {
  const userOfferScreen({super.key});

  @override
  State<userOfferScreen> createState() => _userOfferScreenState();
}

class _userOfferScreenState extends State<userOfferScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userOfferProvider =
          Provider.of<UserOfferProvider>(context, listen: false);
      userOfferProvider.userGetAllOffers(context,false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: 
      SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:Consumer<UserOfferProvider>(
              builder: (context, provider, child) {
                return provider.offerScreenChk?Center(
                  child: CircularProgressIndicator(),
                ) :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.sh,
                Row(
                children: [
                  InkWell(
                    onTap: (){
                Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => userDashboardScreen()),
                        );
                  },
                  child: Icon(Icons.arrow_back_outlined)),12.sw,
                commonText(text: "Offer", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
                ],),20.sh,
                  Center(child: Image(image:AssetImage(ImagePath.appLogo),width: 100,height: 100,)),
                  20.sh,
                Center(child: commonText(text: "Offers", size: 20, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                20.sh,
              ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: AppConstants
                                .userGetAllOffersModel!.data.length,
                            itemBuilder: (context, index)
                            {
                              var offers=AppConstants.userGetAllOffersModel!.data[index];
                              return  Column(
                                children: [
                                  Container(
                                                    width: width(context),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.whiteColor,
                                                      borderRadius: BorderRadius.circular(12)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(children: [
                                                        Row(
                                                          children: [
                                                            commonText(text: "Offer Name:", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                                            commonText(text: offers.name, size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                                                      
                                                          ],
                                                        ),5.sh,
                                                        Row(
                                                          children: [
                                                            commonText(text: "Percentage:", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                                            commonText(text: offers.offPercentage.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                                                      
                                                          ],
                                                        ),5.sh,
                                                        Row(
                                                          children: [
                                                            commonText(text: "Date:", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                                            commonText(text:'${offers.startDate.year}-${offers.startDate.month}-${offers.startDate.day}  ${offers.startDate.hour}:${offers.startDate.minute} To ${offers.endDate.year}-${offers.endDate.month}-${offers.endDate.day}  ${offers.endDate.hour}:${offers.endDate.minute}', size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                                                      
                                                          ],
                                                        ),5.sh,
                                                        Row(
                                                          children: [
                                                            commonText(text: "Program Name:", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                                            commonText(text: offers.programName, size: 14, color: AppColors.blackColor, fontweight: FontWeight.w400),
                                                      
                                                          ],
                                                        ),5.sh,
                                                      ]),
                                                    ),
                                                  ),10.sh,
                                ],
                              );})
        
            ]);}),
          ),
        ),
      )
      ),
    );
  }
}