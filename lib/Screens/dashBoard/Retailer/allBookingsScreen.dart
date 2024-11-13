import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonCard.dart';
import 'package:fyplms/Components/commonSearchBar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/RetailerAllBookingProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/machineProvider.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class AllBookingsScreen extends StatefulWidget {
  const AllBookingsScreen({super.key});

  @override
  State<AllBookingsScreen> createState() => _AllBookingsScreenState();
}

class _AllBookingsScreenState extends State<AllBookingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userOfferProvider =
          Provider.of<RetailerAllBookingProvider>(context, listen: false);
      userOfferProvider.getAllBookings(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:  CommonAppBar(
                title: "Laundry Manager",
          ), 
    ),
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child:Consumer<RetailerAllBookingProvider>(builder: (context,provider,child){
        return provider.bookingChk?Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.sh,
          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RetailerDashboard()),
        );
                },
                child: Icon(Icons.arrow_back_outlined)),12.sw,
              commonText(text: "Bookings ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
            ],
          ),
          20.sh,
            commonSearchBar(
              controller:provider.search,
                  onvaluechange: (value) {
                    if (value.isEmpty) {
                      provider.searchlist = [];
                      provider.hitupdate();
                      return;
                    }
                    provider.searchlist =  AppConstants.retailerAllBookingsModel!.data
                        .where((element) => 
                        element.status.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.programName.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.type.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.price.toString().toLowerCase().contains(value.toString().toLowerCase())
                        )
                        .toList();
                    provider.hitupdate();
                  },),
            20.sh,
            provider.search.text.isEmpty?
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:AppConstants.retailerAllBookingsModel!.data.length,
              itemBuilder: (context,index){
                var bookings=AppConstants.retailerAllBookingsModel!.data[index];
                return  Column(
                  children: [
                    Container(
                      width: width(context),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          commonText(text: "Machine Type: ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w600),
                          commonText(text: bookings.type.toString(), size: 12, color: AppColors.blackColor, fontweight: FontWeight.w400),
                          Spacer(),
                          CommonButton(onPressed: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  children: [
                                    commonText(text: "Time: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.startTime.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    commonText(text: " To ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    commonText(text: bookings.endTime.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),

                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Date: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.date.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Price: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.price.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Status: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.status.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Program Name: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.programName.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),10.sh,

                                Row(
                                  children: [
                                    CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                          provider.updateSpeciBookings(context, bookings.id.toString(), "Cancel");
                                    }, width: width(context)/4, text: "Cancel",height: 35,color: AppColors.primaryColor,),
                                    Spacer(),
                                    CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                          provider.updateSpeciBookings(context, bookings.id.toString(), "Complete");
                                    }, width: width(context)/3, text: "Complete",height: 35,color: AppColors.primaryColor,),

                                  ],
                                )
                              ],
                            ),]
                          );});
                          }, width: width(context)/4, text: "Detail",height: 40,color: AppColors.primaryColor,)
                        ],),
                      ),
                    ),
                    10.sh,
                  ],
                );
              },
            
            ):provider.search.text.isNotEmpty?
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:provider.searchlist.length,
              itemBuilder: (context,index){
                var bookings=provider.searchlist![index];
                return  Column(
                  children: [
                    Container(
                      width: width(context),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                          commonText(text: "Machine Type: ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w600),
                          commonText(text: bookings.type.toString(), size: 12, color: AppColors.blackColor, fontweight: FontWeight.w400),
                          Spacer(),
                          CommonButton(onPressed: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  children: [
                                    commonText(text: "Time: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.startTime.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    commonText(text: " To ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    commonText(text: bookings.endTime.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),

                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Date: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.date.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Price: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.price.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Status: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.status.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),5.sh,
                                Row(
                                  children: [
                                    commonText(text: "Program Name: ", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w600),
                                    commonText(text: bookings.programName.toString(), size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),5.sh,
                                    
                                  ],
                                ),10.sh,

                                Row(
                                  children: [
                                    CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                          provider.updateSpeciBookings(context, bookings.id.toString(), "Cancel");
                                    }, width: width(context)/4, text: "Cancel",height: 35,color: AppColors.primaryColor,),
                                    Spacer(),
                                    CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                          provider.updateSpeciBookings(context, bookings.id.toString(), "Complete");
                                    }, width: width(context)/3, text: "Complete",height: 35,color: AppColors.primaryColor,),

                                  ],
                                )
                              ],
                            ),]
                          );});
                          }, width: width(context)/4, text: "Detail",height: 40,color: AppColors.primaryColor,)
                        ],),
                      ),
                    ),
                    10.sh,
                  ],
                );
              },
            
            ):  commonText(
                                  text: "No Search Found",
                                  fontweight: FontWeight.w600,
                                  size: 22,
                                  color: AppColors.primaryColor),
        ]);})
      ),
    ),
    );
  }
}