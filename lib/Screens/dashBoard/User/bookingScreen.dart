import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/userDashboardProvider.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Screens/dashBoard/User/userWidgets/bookingCardWidget.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class bookingScreen extends StatefulWidget {
  const bookingScreen({super.key});

  @override
  State<bookingScreen> createState() => _bookingScreenState();
}

class _bookingScreenState extends State<bookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userDashboardProvider =
          Provider.of<UserDashbardProvider>(context, listen: false);
      userDashboardProvider.getAllBookings(context);
    });
  }

  @override
  void dispose() {
    final userDashboardProvider =
        Provider.of<UserDashbardProvider>(context, listen: false);
        userDashboardProvider.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(width(context), 90),
        child: CommonAppBar(
          title: "User",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Consumer<UserDashbardProvider>(
              builder: (context, provider, child) {
                return provider.programChk
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 20),
                      
                      provider.popChk?Container(
                        width: width(context),
                        decoration: BoxDecoration(
                          color: AppColors.redColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: InkWell(
                          onTap: (){
                            provider.removeAlert();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: commonText(text: "Time is up please pick your cloth", size: 12, color: AppColors.redColor, fontweight: FontWeight.w600),
                          ))):SizedBox(),

                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          userDashboardScreen(),
                                    ),
                                  );
                                },
                                child: Icon(Icons.arrow_back_outlined),
                              ),
                              SizedBox(width: 12),
                              commonText(
                                text: "Bookings",
                                size: 18,
                                color: AppColors.blackColor,
                                fontweight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: AppConstants
                                .userGetAllBookingsModel!.data.length,
                            itemBuilder: (context, index) {
                              provider.initializeBookingDetails(index);

                              String startTime = provider.convertTo12HourFormat(
                                  AppConstants.userGetAllBookingsModel!
                                      .data[index].startTime
                                      .toString());
                              String endTime = provider.convertTo12HourFormat(
                                  AppConstants.userGetAllBookingsModel!
                                      .data[index].endTime
                                      .toString());

                              return provider.buildCounterText(index) == "Past" ||AppConstants.userGetAllBookingsModel!.data[index].status.toString()=="Cancel"
                                  ? SizedBox()
                                  : Column(
                                      children: [
                                        bookingCard(
                                          delIconClick: (){
                                            provider.updateSpeciBookings(context,
                                            AppConstants.userGetAllBookingsModel!.data[index].id.toString(),
                                            "Cancel");
                                          },
                                          context: context,
                                          imag: AppConstants
                                                      .userGetAllBookingsModel!
                                                      .data[index]
                                                      .type
                                                      .toString() ==
                                                  "Washer"
                                              ? ImagePath.washingMachineIcon
                                              : ImagePath.DryMachineIcon,
                                          counterColor: Colors.green,
                                          title: 'Machine Code:${AppConstants
                                              .userGetAllBookingsModel!
                                              .data[index]
                                              .programName
                                              .toString()}',
                                          subtitle: AppConstants
                                              .userGetAllBookingsModel!
                                              .data[index]
                                              .type
                                              .toString(),
                                          buttonText: "Detail",
                                          counter: provider.buildCounterText(
                                                      index) ==
                                                  "Future"
                                              ? ""
                                              : provider.getRemainingTime(context,index),
                                          delImag: provider.buildCounterText(
                                                      index) ==
                                                  "Present"
                                              ? ""
                                              : ImagePath.delIcon,
                                          buttonClick: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context1) {
                                                return AlertDialog(
                                                  icon: Image(
                                                    image: AssetImage(
                                                        ImagePath.eyeIcon),
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                  title:
                                                      Text("Booking Detail"),
                                                  actions: <Widget>[
                                                    Center(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              commonText(
                                                                  text: "Date: ",
                                                                  size: 16,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600),
                                                              commonText(
                                                                  text: DateFormat(
                                                                          'yyyy-MM-dd')
                                                                      .format(AppConstants
                                                                          .userGetAllBookingsModel!
                                                                          .data[
                                                                              index]
                                                                          .date)
                                                                      .toString(),
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w400),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              commonText(
                                                                  text: "Time: ",
                                                                  size: 16,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600),
                                                              commonText(
                                                                  text:
                                                                      '${startTime.toString()} To ${endTime.toString()}',
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w400),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              commonText(
                                                                  text: "Price: ",
                                                                  size: 16,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600),
                                                              commonText(
                                                                  text: AppConstants
                                                                      .userGetAllBookingsModel!
                                                                      .data[index]
                                                                      .price
                                                                      .toString(),
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w400),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              commonText(
                                                                  text: "Type: ",
                                                                  size: 16,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600),
                                                              commonText(
                                                                  text: AppConstants
                                                                      .userGetAllBookingsModel!
                                                                      .data[index]
                                                                      .type
                                                                      .toString(),
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w400),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            children: [
                                                              commonText(
                                                                  text: "Branch Name: ",
                                                                  size: 16,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600),
                                                              commonText(
                                                                  text: AppConstants
                                                                      .userGetAllBookingsModel!
                                                                      .data[index]
                                                                      .branchName
                                                                      .toString(),
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .blackColor,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w400),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          CommonButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              width: width(context),
                                                              text: "Ok",
                                                              color: AppColors.primaryColor,
                                                              height: 50),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    );
                            },
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
