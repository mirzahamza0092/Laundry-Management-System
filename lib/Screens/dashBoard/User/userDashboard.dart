import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/userDashboardProvider.dart';
import 'package:fyplms/Screens/Auth/LoginScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/bookingScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/findLaundryScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/meScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userBulkClothScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userOfferScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userWidgets/cycleWidget.dart';
import 'package:fyplms/Screens/dashBoard/User/userWidgets/dateTimePickerWidget.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class userDashboardScreen extends StatefulWidget {
  const userDashboardScreen({super.key});

  @override
  State<userDashboardScreen> createState() => _userDashboardScreenState();
}

class _userDashboardScreenState extends State<userDashboardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userdDashBoardP =Provider.of<UserDashbardProvider>(context, listen: false);
    userdDashBoardP.getAllBranches(context);
    userdDashBoardP.getAllMachineCycle(context);
    userdDashBoardP.getAllMachineCapacities(context);
    userdDashBoardP. getAllItems(context);
    });
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<UserDashbardProvider>(builder: (context,provider,child){
        return provider.fetchDatChk?Center(child: CircularProgressIndicator()): Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              provider.dryerYesOrNoChk?
              Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                      provider.dontWantDryer(context);
                        },
                        child: Icon(Icons.arrow_back_outlined)),12.sw,
                      commonText(text: "Back", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                  ],
                                ),
                    ):
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                  child: Stack(
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
                                    zoom: 11.0,
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
              provider.dryerYesOrNoChk?SizedBox():  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonButton(onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => bookingScreen()),
                                      );
                          }, width: width(context)/3.5, text: "Bookings",color: AppColors.primaryColor,height: 40,),5.sh,
                          
                          CommonButton(onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => userOfferScreen()),
                                      );
                          }, width: width(context)/3.5, text: "Offers",color: AppColors.primaryColor,height: 40,),5.sh,
                          CommonButton(onPressed: (){
                          Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) =>LoginScreen()));
                          }, width: width(context)/3.5, text: "Logout",color: AppColors.primaryColor,height: 40,)
                  
                        ],
                      ),
                ),
                10.sh,
              provider.dryerYesOrNoChk?SizedBox():  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        commonText(text: "Washer", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                        InkWell(
                          onTap: (){
                            provider.changesMachineChk(context);
                          },
                          child: Stack(
                            children: [
                              Image(image:AssetImage(ImagePath.washingMachineIcon),width: 110,height: 110,),
                              Positioned(
                                bottom: 0,right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child:provider.machinesChk? Image(image:AssetImage(ImagePath.tickIcon),width: 50,height: 50,):SizedBox(),
                                )),
                              ]),
                        )
                        ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        width: 20,
                        height: 2,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Column(
                      children: [
                        commonText(text: "Dryer", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                        InkWell(
                          onTap: (){
                            provider.changesMachineChk(context);
                          },
                          child: Stack(
                            children: [
                              Image(image:AssetImage(ImagePath.DryMachineIcon),width: 110,height: 110,),
                              Positioned(
                                bottom: 0,right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child:provider.machinesChk?SizedBox(): Image(image:AssetImage(ImagePath.tickIcon),width: 50,height: 50,),
                                )),
                              ]),
                        )                        ],
                    ),
                    
                    // Column(
                    //   children: [
                    //     commonText(text: "Bulk Order", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                    //     InkWell(
                    //       onTap: (){
                    //         Navigator.of(context).push(
                    //         MaterialPageRoute(builder: (context) => BulkBrachesScreen()),
                    //                 );
                    //       },
                    //       child: Image(image:AssetImage(ImagePath.bulkIcon),width: 110,height: 110,),
                    //     )                        ],
                    // ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:provider.programChk?Center(child: CircularProgressIndicator()): Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText(text: "Schedule Time", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                      15.sh,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          dateTimePickerWidget(context: context,text: '${provider.selectedTime.hour.toString()}:${provider.selectedTime.minute.toString()}:${provider.selectedTime.period.name.toUpperCase().toString()}',image: ImagePath.clockIcon,onClick: (){
                            provider.selectTime(context);
                          }),
                          dateTimePickerWidget(context: context,text: '${provider.selectedDate.year.toString()}-${provider.selectedDate.month.toString()}-${provider.selectedDate.day.toString()}',image: ImagePath.calenderIcon,onClick: (){
                            provider.selectDate(context);
                          }),

                        ],
                      ),20.sh,
                      Row(
                        children: [
                          commonText(text: "Want Multiple Machines ?", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              border:Border.all(color: AppColors.blackColor,width: 2),
                              borderRadius: BorderRadius.circular(12)
                              ),
                            child: CommonDropDown(
                                                  color: AppColors.backgroundColor,
                                                  width: width(context)/4, selectedText: provider.limitText, listItem: provider.limit, onchanged: (val){
                                                  provider.limitOnChange(val);
                                                }),
                          ),
                        ],
                      ),
                    20.sh,
                      Container(
                        width: width(context),
                          decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                          provider.machinesChk==false?Column(
                          children: [
                        commonProgrames(
                          title: "Dry Cycle",
                          selectedText: provider.selectedCycle.toString(),
                          context: context,
                          itemList: provider.cycleList,
                          onChange: (val){
                            provider.washCycleValue(val);
                          },
                          eyeOnClick: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Dry Cycle", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Dry Time", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Heat Level", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getMachineCycleModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:'${AppConstants.getMachineCycleModel!.data[index].duration.toString()} min', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].temprature.toString()}', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                  
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );});
                          }
                        ),
                          ],
                        ):Column(
                          children: [
                        commonProgrames(
                          title: "Wash Cycle",
                          selectedText: provider.selectedCycle.toString(),
                          context: context,
                          itemList: provider.cycleList,
                          onChange: (val){
                            provider.washCycleValue(val);
                          },
                          eyeOnClick: (){
                                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Wash Cycle", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Water Temp", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Wash Time", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Spin Speed", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getMachineCycleModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:AppConstants.getMachineCycleModel!.data[index].temprature.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].duration.toString()} min', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].spinSpeed.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                                
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );}); }
                        ),
                          ],
                        ),
                        
                        20.sh,
                                            commonProgrames(
                          title: "Capacity",
                          selectedText: provider.selectedCapacity.toString(),
                          context: context,
                          itemList: provider.capacityList,
                          onChange: (val){
                            provider.washCapacityValue(val);
                          },
                          eyeOnClick: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Capacity", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Weight ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Quantity ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getAllMachineCapacitesModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getAllMachineCapacitesModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:'${AppConstants.getAllMachineCapacitesModel!.data[index].loadCapacityDescription.toString()} Kg', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getAllMachineCapacitesModel!.data[index].loadCapacity.toString()} Suit', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getAllMachineCapacitesModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                  
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );});
                          }
                        ),
                          ],
                        ),
                      ),
                        10.sh,

                      provider.limitText=="2"|| provider.limitText=="3"?
                      Container(
                        width: width(context),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                          provider.machinesChk==false?Column(
                          children: [
                        commonProgrames(
                          title: "Dry Cycle",
                          selectedText: provider.selectedCycle2.toString(),
                          context: context,
                          itemList: provider.cycleList2,
                          onChange: (val){
                            provider.washCycleValue2(val);
                          },
                          eyeOnClick: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Dry Cycle", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Dry Time", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Heat Level", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getMachineCycleModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:'${AppConstants.getMachineCycleModel!.data[index].duration.toString()} min', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].temprature.toString()}', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                  
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );});
                          }
                        ),
                          ],
                        ):Column(
                          children: [
                        commonProgrames(
                          title: "Wash Cycle",
                          selectedText: provider.selectedCycle2.toString(),
                          context: context,
                          itemList: provider.cycleList2,
                          onChange: (val){
                            provider.washCycleValue2(val);
                          },
                          eyeOnClick: (){
                                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Wash Cycle", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Water Temp", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Wash Time", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Spin Speed", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getMachineCycleModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:AppConstants.getMachineCycleModel!.data[index].temprature.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].duration.toString()} min', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].spinSpeed.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                                
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );}); }
                        ),
                          ],
                        ),
                        
                        20.sh,
                        commonProgrames(
                          title: "Capacity",
                          selectedText: provider.selectedCapacity2.toString(),
                          context: context,
                          itemList: provider.capacityList2,
                          onChange: (val){
                            provider.washCapacityValue2(val);
                          },
                          eyeOnClick: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Capacity", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Weight ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Quantity ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getAllMachineCapacitesModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getAllMachineCapacitesModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:'${AppConstants.getAllMachineCapacitesModel!.data[index].loadCapacityDescription.toString()} Kg', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getAllMachineCapacitesModel!.data[index].loadCapacity.toString()} Suit', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getAllMachineCapacitesModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                  
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );});
                          }
                        ),
                        
                        
                          ],
                        ),
                      ):SizedBox(),
                      10.sh,
                      provider.limitText=="3"?
                      Container(
                        width: width(context),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                          provider.machinesChk==false?Column(
                          children: [
                        commonProgrames(
                          title: "Dry Cycle",
                          selectedText: provider.selectedCycle3.toString(),
                          context: context,
                          itemList: provider.cycleList3,
                          onChange: (val){
                            provider.washCycleValue3(val);
                          },
                          eyeOnClick: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Dry Cycle", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Dry Time", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Heat Level", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getMachineCycleModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:'${AppConstants.getMachineCycleModel!.data[index].duration.toString()} min', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].temprature.toString()}', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                  
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );});
                          }
                        ),
                          ],
                        ):Column(
                          children: [
                        commonProgrames(
                          title: "Wash Cycle",
                          selectedText: provider.selectedCycle3.toString(),
                          context: context,
                          itemList: provider.cycleList3,
                          onChange: (val){
                            provider.washCycleValue3(val);
                          },
                          eyeOnClick: (){
                                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Wash Cycle", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Water Temp", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Wash Time", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Spin Speed", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getMachineCycleModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:AppConstants.getMachineCycleModel!.data[index].temprature.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].duration.toString()} min', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: AppConstants.getMachineCycleModel!.data[index].spinSpeed.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getMachineCycleModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                                
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );}); }
                        ),
                          ],
                        ),
                        
                        20.sh,
                                            commonProgrames(
                          title: "Capacity",
                          selectedText: provider.selectedCapacity3.toString(),
                          context: context,
                          itemList: provider.capacityList3,
                          onChange: (val){
                            provider.washCapacityValue3(val);
                          },
                          eyeOnClick: (){
                            showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Expanded(child: commonText(text: "Capacity", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Weight ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Quantity ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                  Expanded(child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                                
                                  ],
                                ),5.sh,
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConstants.getAllMachineCapacitesModel!.data.length,
                                  itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Expanded(child: commonText(text: AppConstants.getAllMachineCapacitesModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text:'${AppConstants.getAllMachineCapacitesModel!.data[index].loadCapacityDescription.toString()} Kg', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getAllMachineCapacitesModel!.data[index].loadCapacity.toString()} Suit', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                    Expanded(child: commonText(text: '${AppConstants.getAllMachineCapacitesModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                  
                                    ],
                                  );
                                }),
                                10.sh,
                                CommonButton(onPressed: (){
                                      Navigator.of(context).pop();
                                }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                              ],
                            ),]
                          );});
                          }
                        ),
                        
                          ],
                        ),
                      ):SizedBox(),
                      
                      10.sh,
                      
                        Row(
                      children: [
                        commonText(text: "Quantity:", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                        5.sw,
                        Consumer<UserDashbardProvider>(builder: (context,provider,child){
                          return Container(
                          width: width(context)/2,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CommonButton(onPressed: (){
                                  provider.productQuantityDec(context);
                                }, width: width(context)/8, text: "-",color: AppColors.primaryColor,height: 25,),
                              commonText(text: provider.productQuantity.toString(), size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                              CommonButton(onPressed: (){
                                  provider.productQuantityInc();
                                }, width: width(context)/8, text: "+",color: AppColors.primaryColor,height: 25,),
                            ],
                            ),
                          ),
                        );}),Spacer(),
                        InkWell(
                          onTap: (){
                            provider.addSelectedProducts(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(25)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.done,color: AppColors.whiteColor,),
                            )),
                        )
                      ],
                                              ),10.sh,
                      commonProgrames(
                        title: "Products",
                        context: context,
                        selectedText: provider.selectedProduct.toString(),
                        itemList: provider.productList,
                        onChange: (val){
                        provider.washProductValue(val);
                                                  },
                        eyeOnClick: (){
                        showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                        actions: [
                          Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Expanded(child: commonText(text: "Product Name", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                              Expanded(child: commonText(text: "Price ", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w600)),3.sw,
                            
                              ],
                            ),
                            5.sh,
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: AppConstants.getAllItemsModel!.data.length,
                              itemBuilder: (context,index){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Expanded(child: commonText(text: AppConstants.getAllItemsModel!.data[index].name.toString(), size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                Expanded(child: commonText(text:'${AppConstants.getAllItemsModel!.data[index].price.toString()} Rs', size: 10, color: AppColors.blackColor, fontweight: FontWeight.w500)),3.sw,
                                
                                ],
                              );
                            }),
                            10.sh,
                            CommonButton(onPressed: (){
                                  Navigator.of(context).pop();
                            }, width: width(context)/4, text: "OK",color: AppColors.primaryColor,height: 30,)
                          ],
                        ),]
                                                  );});
                                                  }
                                                ),
                                                10.sh,
                    provider.selectedProducts.isEmpty?SizedBox(): 
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.selectedProducts.length,
                      itemBuilder: (context,index){
                      return  Column(
                        children: [
                          Container(
                            width: width(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.whiteColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  commonText(text:  provider.selectedProducts[index].name.toString(), size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                  commonText(text:  provider.selectedProducts[index].quantity.toString(), size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                  InkWell(
                                    onTap: (){
                                      int id=int.parse(provider.selectedProducts[index].id);
                                      provider.removeSelectedProducts(id);
                                    },
                                    child: Image(image:AssetImage(ImagePath.delIcon),width: 40,height: 40,))
                              ]),
                            ),
                          ),
                          5.sh,
                        ],
                      ); }),
                      10.sh,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonText(text: "Distance:", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                        5.sw,
                        Consumer<UserDashbardProvider>(builder: (context,provider,child){
                          return Container(
                          width: width(context)/2,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CommonButton(onPressed: (){
                                  provider.distanceDec(context);
                                }, width: width(context)/8, text: "-",color: AppColors.primaryColor,height: 25,),
                                // InkWell(
                                //   onTap: (){
                                //     provider.distanceDec(context);
                                //   },
                                //   child: 
                                //   commonText(text: "-", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                                commonText(text: provider.distance.toString(), size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                                // InkWell(
                                //   onTap: (){
                                //     provider.distanceInc();
                                //   },
                                //   child: commonText(text: "+", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                            CommonButton(onPressed: (){
                                  provider.distanceInc();
                                }, width: width(context)/8, text: "+",color: AppColors.primaryColor,height: 25,),
                            ],
                            ),
                          ),
                        );}),
                        Spacer(),
                      commonText(text:"Km", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),10.sw,
                      
                      ],
                                              ),
                          10.sh,                    
                        Row(
                      children: [
                        commonText(text: "Cycle:", size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                        25.sw,
                        Consumer<UserDashbardProvider>(builder: (context,provider,child){
                          return Container(
                          width: width(context)/2,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CommonButton(onPressed: (){
                                  provider.roundDec(context);
                                }, width: width(context)/8, text: "-",color: AppColors.primaryColor,height: 25,),
                              commonText(text: provider.round.toString(), size: 16, color: AppColors.blackColor, fontweight: FontWeight.w500),
                              CommonButton(onPressed: (){
                                  provider.roundInc(context);
                                }, width: width(context)/8, text: "+",color: AppColors.primaryColor,height: 25,),
                            ],
                            ),
                          ),
                        );}),
                        
                      ],
                                              ),
                    provider.selectedProducts.isEmpty?
                    commonText(text:provider.showMsg, size: 12, color: AppColors.redColor, fontweight: FontWeight.w500):SizedBox(),
                    20.sh,
                    provider.findLaundryChk?Center(
                      child: CircularProgressIndicator(),
                    ):  CommonButton(onPressed: (){
                        provider.findLaundry(context);
                      }, width: width(context), text: "Find Laundry",
                      color: AppColors.primaryColor,
                      ),20.sh
                    ],
                  ),
                )
              ],
            ),
          );})
        ),
      )
    );
  }
}