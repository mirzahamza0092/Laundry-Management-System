import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/userDashboardProvider.dart';
import 'package:fyplms/Screens/dashBoard/User/bookingDetailScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Screens/dashBoard/User/userWidgets/commonFilterCard.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class findLaundryScreen extends StatefulWidget {
  const findLaundryScreen({super.key});

  @override
  State<findLaundryScreen> createState() => _findLaundryScreenState();
}

class _findLaundryScreenState extends State<findLaundryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child:Consumer<UserDashbardProvider>(builder: (context,provider,child){
                return Column(
                  children: [
            Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                      child:  Stack(
                    children: [
                      Container(
                        height: 450,
                        width: width(context),
                        decoration: BoxDecoration(
                          border:Border.all(color:AppColors.blackColor,width: 3),
                          borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GoogleMap(
                                  onMapCreated: provider.onMapCreated,
                                  markers: provider.locationMarkers,
                                  initialCameraPosition: CameraPosition(
                                    target: provider.userLocation, // Replace with your desired initial location
                                    zoom: 10.0,
                                  ),
                                  myLocationEnabled: true,
                                  myLocationButtonEnabled: true,
                                  zoomGesturesEnabled: true,
                                  scrollGesturesEnabled: true,
                                  tiltGesturesEnabled: true,
                                  rotateGesturesEnabled: true, // Enable zoom controls (optional)
                                ),
                          ),
                      ),
                      ]
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => userDashboardScreen()),
                              );
                        },
                        child: Icon(Icons.arrow_back_outlined)),12.sw,
                      commonText(text: "Back", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                  ],
                                ),
                    ),
        
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.allAvailableB.length,
                      itemBuilder: (context,index){
                        int distance=provider.allAvailableB[index].distance.toInt();
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0),
                        child: Column(
                          children: [
                            commonFilterCard(
                              image: ImagePath.branchIcon,
                              context: context,
                              title: provider.allAvailableB[index].branchName,
                              button1Text: "Proceed",
                              // button2Text: "Declined ",
                              distanceText: distance.toString(),
                              button1Click: (){
                                provider.branchNameStore(
                                  provider.allAvailableB[index].branchName,
                                  provider.allAvailableB[index].branchId.toString(),
                                  context);
                              }
                              ),
                            10.sh,
                          ],
                        ),
                      );
                    })
          ]);})
        ),
      ),
    );
  }
}