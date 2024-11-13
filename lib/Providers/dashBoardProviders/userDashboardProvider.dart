import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Models/AdminDashBoardModels/branchesModel.dart';
import 'package:fyplms/Models/UserAllModels/productsModelList.dart';
import 'package:fyplms/Models/UserAllModels/saveMultipleDataModel.dart';
import 'package:fyplms/Models/UserAllModels/userGetAllMachineModel.dart';
import 'package:fyplms/Models/UserAllModels/userGetMachineModel.dart';
import 'package:fyplms/Screens/dashBoard/User/bookingDetailScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/findLaundryScreen.dart';
import 'package:fyplms/Screens/dashBoard/User/userDashboard.dart';
import 'package:fyplms/Services/dashBoard/bookingService.dart';
import 'package:fyplms/Services/dashBoard/userAllBookingService.dart';
import 'package:fyplms/Services/dashBoard/userAllMachineService.dart';
import 'package:fyplms/Services/dashBoard/userWashCycleService.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fyplms/Services/dashBoard/branchesServices.dart';

class UserDashbardProvider with ChangeNotifier{
  bool machinesChk=true;
  bool fetchDatChk=false;
  bool programChk=false;
  bool findLaundryChk=false;
  bool dryerYesOrNoChk=false;
  String showMsg="";
  String? selectedCycle,selectedCycleId;
  String? selectedCycle2,selectedCycleId2;
  String? selectedCycle3,selectedCycleId3;
  int productQuantity=1;
Timer? timer;
  String? selectedCapacity,selectedCapacityId;
  String? selectedCapacity2,selectedCapacityId2;
  String? selectedCapacity3,selectedCapacityId3;

  String? selectedProduct,selectedProductId;

  List<String> cycleList=[];
  List<String> cycleList2=[];
  List<String> cycleList3=[];

  List<String> capacityList=[];
  List<String> capacityList2=[];
  List<String> capacityList3=[];
  String? alert,alert2;
  
  String branchName="",branchId="";
  String allProductsString="";
  List<String> productList=[];
  List<productListModel> selectedProducts=[];
  List<BranchesList> allAvailableB=[];
  List<MachinesList> allAvailableM=[];
  String googleMapsApiKey = "AIzaSyAK4M5dY-0P9pDc12nBdHnsmyCkFJMENSQ";
  int round=1;
  String limitText="1";
  List<String> limit=["1","2","3"];
  int distance=1;
  List<LatLng> branchListLocations=[];
   Set<Marker> locationMarkers = {};
  GoogleMapController? mapController;
  LatLng userLocation=const LatLng(0.0, 0.0);
    TimeOfDay selectedTime = TimeOfDay.now();
    DateTime selectedDate = DateTime.now();
    String? userLatitude,userLongitude;

  Future<bool> requestLocationPermission() async {
    var locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }
  // addCount(){
  //   count++;
  //   notifyListeners();
    
  //   print(count);
    
  //   notifyListeners();
  // }
  // removeCount(){
  //   count--;
  //   print(count);
  //   notifyListeners();
  // }
  findLaundry(BuildContext context){
    if(selectedProducts.isEmpty){
      showMsg="Add Products";
      notifyListeners();
    }
    else{
      showMsg="";
      getAllAvailableBranches(context);
    }
  }
getAllAvailableBranches(BuildContext context)async{
  try{
    findLaundryChk=true;
    notifyListeners();
    String selectedOption=machinesChk?"washer":"dryer";
    String bookingDate=getCombinedDateTime();
    String programIdTwo=limitText=="2"||limitText=="3"?selectedCycleId2.toString():"0";
    String programIdThree=limitText=="3"?selectedCycleId3.toString():"0";
    String capacityIdTwo=limitText=="2"||limitText=="3"?selectedCapacityId2.toString():"0";
    String capacityIdThree=limitText=="3"?selectedCapacityId3.toString():"0";

          var response=await UserGetAllMachines.getAllMachines(
            selectedOption:selectedOption,
            bookingDate:bookingDate,
            programIdOne:selectedCycleId.toString(),
            capacityIdOne:selectedCapacityId.toString(),
            programIdTwo:programIdTwo,
            capacityIdTwo:capacityIdTwo,
            programIdThree:programIdThree,
            capacityIdThree:capacityIdThree,
            machinesNeeded:limitText,
            laundryIntervals:round.toString(),
            distance: distance.toString(),
            // latitude:userLatitude.toString(),
            // longitude: userLongitude.toString(),
            latitude:"33.6433",
            longitude: "73.0790",
            allProducts:selectedProducts,
            context: context,);

          if(response!=null){
            AppConstants.userGetAllMachinesModel=response;
            allAvailableB=AppConstants.userGetAllMachinesModel!.data.branchesList;
            allAvailableM=AppConstants.userGetAllMachinesModel!.data.machinesList;
            findLaundryChk=false;
            Navigator.push(context,MaterialPageRoute(builder: (context) => findLaundryScreen()),);
          }
          findLaundryChk=false;
          notifyListeners();
  }catch (exception) {
      print(exception);
    }
}
clearData(){
selectedProducts=[];
            distance=1;
            round=1;
            productQuantity=1;
            limitText="1";
            notifyListeners();
}
bookingDoneCall(BuildContext context,bool chk)async{
  try{
    dryerYesOrNoChk=true;
    notifyListeners();
    String selectedOption=machinesChk?"washer":"dryer";
          var response=await BookingService.bookingDone(
            laundryIntervals: round.toString(),
            branchId:branchId ,
            selectedOption:selectedOption,
            allProducts:selectedProducts,
            machinesList:allAvailableM ,
            context: context);

          if(response!=null){
            bookingDone(chk);
            clearData();
            findLaundryChk=false;
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>new userDashboardScreen()),);

          }
          
          findLaundryChk=false;
          notifyListeners();
  }catch (exception) {
      print(exception);
    }
}

bookingDone(bool chk){
  dryerYesOrNoChk=chk;
  notifyListeners();
  if(dryerYesOrNoChk){
    machinesChk=false;
    notifyListeners();
  }
}
dontWantDryer(BuildContext context){
  dryerYesOrNoChk=false;
  notifyListeners();
Navigator.push(context,MaterialPageRoute(builder: (context) => userDashboardScreen()),);
}
branchNameStore(String bName,String bId,BuildContext context){
  allProductsString="";
  branchName=bName;
  branchId=bId;
  notifyListeners();
  for(int i=0;i<selectedProducts.length;i++){
    allProductsString=allProductsString + selectedProducts[i].name.toString();
    allProductsString=allProductsString + ",";
  }
  Navigator.of(context).push( MaterialPageRoute(builder: (context) => bookingDetailScreen()));
  notifyListeners();
} 
Future<void> getUserLocation() async {
    bool hasPermission = await requestLocationPermission();
    if (!hasPermission) return;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // ignore: unrelated_type_equality_checks
    if (position!=null) {
        userLocation = LatLng(position.latitude, position.longitude);
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(userLocation, 15.0),
      );
      locationMarkers.add(
          Marker(
            markerId: MarkerId('userLocation'),
            position: userLocation,
            icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),

          ),
        );
        userLatitude=position.latitude.toString();
        userLongitude=position.longitude.toString();
        notifyListeners();
    }
    notifyListeners();
  }

  addSelectedProducts(BuildContext context) {
  String id = selectedProductId.toString();
  String name = selectedProduct.toString();
  String quantity = productQuantity.toString();
  bool exists = false;
  
  for (int i = 0; i < selectedProducts.length; i++) {
    if (selectedProducts[i].id.toString() == selectedProductId) {
      exists = true;
      break;
    }
  }
  if (exists) {
    ScaffoldMessenger.of(context).showSnackBar(appSnackBar("Already Exist"));
  } else {
    selectedProducts.add(
      productListModel(id: id, name: name, quantity: quantity)
    );
    notifyListeners();
  }

  notifyListeners();
}
removeSelectedProducts(int id){
selectedProducts.removeWhere((product) => int.parse(product.id) == id);
notifyListeners();
}

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (userLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(userLocation, 15.0),
      );
    }
    notifyListeners();
  }
  limitOnChange(String val){
    limitText=val;
    notifyListeners();
  }
   void addBranchMarkers() {
    locationMarkers={};
      for (int i = 0; i < branchListLocations.length; i++) {
        locationMarkers.add(
          Marker(
            markerId: MarkerId('branch_$i'),
            position: branchListLocations[i],
            icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: 'Branch ${i + 1}'),
          ),
        );
      }
      notifyListeners();
  }
  getAllData(BuildContext context){
    getAllBranches(context);
    getAllMachineCycle(context);
    getAllMachineCapacities(context);
    getAllItems(context);
    notifyListeners();
  }
getAllBranches(BuildContext context)async{
    try{
        fetchDatChk=true;
        notifyListeners();
          var response=await branchService.getAllBranches(context: context,branchChk: false);
          if(response!=null){
            getUserLocation();
      if(response is UserGetMachineModel){
        branchListLocations=[];
            AppConstants.userGetBranchesModel=response;
          AppConstants.userGetBranchesModel!.data.forEach((element) {
            branchListLocations.add(LatLng(element.latitude, element.longitude));
            print('brancheessss${branchListLocations}');
          
          });
          addBranchMarkers();
          fetchDatChk=false;
          notifyListeners();
          }
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    fetchDatChk=false;
    notifyListeners();
  }


    washCycleValue(String val){
      selectedCycle=val;
      notifyListeners();
      for (int i = 0; i < cycleList.length; i++) {
      if (AppConstants.getMachineCycleModel!.data[i].name.toString() == val) {
        selectedCycleId = AppConstants.getMachineCycleModel!.data[i].id.toString();
        debugPrint(selectedCycleId.toString());
      }
    }
      notifyListeners();
    }
    washCycleValue2(String val){
      selectedCycle2=val;
      notifyListeners();
      for (int i = 0; i < cycleList2.length; i++) {
      if (AppConstants.getMachineCycleModel!.data[i].name.toString() == val) {
        selectedCycleId2 = AppConstants.getMachineCycleModel!.data[i].id.toString();
        debugPrint(selectedCycleId2.toString());
      }
    }
      notifyListeners();
    }
    washCycleValue3(String val){
      selectedCycle3=val;
      notifyListeners();
      for (int i = 0; i < cycleList3.length; i++) {
      if (AppConstants.getMachineCycleModel!.data[i].name.toString() == val) {
        selectedCycleId3 = AppConstants.getMachineCycleModel!.data[i].id.toString();
        debugPrint(selectedCycleId3.toString());
      }
    }
      notifyListeners();
    }



    washCapacityValue(String val){
      selectedCapacity=val;
      notifyListeners();
      for (int i = 0; i < capacityList.length; i++) {
      if (AppConstants.getAllMachineCapacitesModel!.data[i].name.toString() == val) {
        selectedCapacityId = AppConstants.getAllMachineCapacitesModel!.data[i].id.toString();
        debugPrint(selectedCapacityId.toString());
      }
    }
      notifyListeners();
    }

washCapacityValue2(String val){
      selectedCapacity2=val;
      notifyListeners();
      for (int i = 0; i < capacityList2.length; i++) {
      if (AppConstants.getAllMachineCapacitesModel!.data[i].name.toString() == val) {
        selectedCapacityId2 = AppConstants.getAllMachineCapacitesModel!.data[i].id.toString();
        debugPrint(selectedCapacityId2.toString());
      }
    }
      notifyListeners();
    }

    washCapacityValue3(String val){
      selectedCapacity3=val;
      notifyListeners();
      for (int i = 0; i < capacityList3.length; i++) {
      if (AppConstants.getAllMachineCapacitesModel!.data[i].name.toString() == val) {
        selectedCapacityId3 = AppConstants.getAllMachineCapacitesModel!.data[i].id.toString();
        debugPrint(selectedCapacityId3.toString());
      }
    }
      notifyListeners();
    }



    washProductValue(String val){
      selectedProduct=val;
      notifyListeners();
      for (int i = 0; i < productList.length; i++) {
      if (AppConstants.getAllItemsModel!.data[i].name.toString() == val) {
        selectedProductId = AppConstants.getAllItemsModel!.data[i].id.toString();
        debugPrint(selectedProductId.toString());
      }
    }
    }


  changesMachineChk(BuildContext context){
    machinesChk=!machinesChk;
    limitText="1";
    productQuantity=1;
    round=1;
    selectedProducts=[];
    getAllMachineCycle(context);
    getAllMachineCapacities(context);
    getAllItems(context);
    notifyListeners();
  }
  getAllMachineCycle(BuildContext context)async{
    try{
      programChk=true;
        notifyListeners();
          var response=await userWashCycleService.getWashCycleProgram(context: context,machineChk: machinesChk);
          if(response!=null){
            cycleList=[];
            cycleList2=[];
            cycleList3=[];
            AppConstants.getMachineCycleModel=response;
            AppConstants.getMachineCycleModel!.data.forEach((element) {

            selectedCycle = AppConstants.getMachineCycleModel!.data[0].name.toString();
            selectedCycleId = AppConstants.getMachineCycleModel!.data[0].id.toString();
            cycleList.add(element.name.toString());

            selectedCycle2 = AppConstants.getMachineCycleModel!.data[0].name.toString();
            selectedCycleId2 = AppConstants.getMachineCycleModel!.data[0].id.toString();
            cycleList2.add(element.name.toString());

            selectedCycle3 = AppConstants.getMachineCycleModel!.data[0].name.toString();
            selectedCycleId3 = AppConstants.getMachineCycleModel!.data[0].id.toString();
            cycleList3.add(element.name.toString());
          });
          
          programChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    fetchDatChk=false;
    notifyListeners();
  }
  getAllMachineCapacities(BuildContext context)async{
    try{
      programChk=true;
        notifyListeners();
          var response=await userWashCycleService.getWashCapacities(context: context,machineChk: machinesChk);
          if(response!=null){
            capacityList=[];
            capacityList2=[];
            capacityList3=[];
            AppConstants.getAllMachineCapacitesModel=response;
            AppConstants.getAllMachineCapacitesModel!.data.forEach((element) {

            selectedCapacity = AppConstants.getAllMachineCapacitesModel!.data[0].name.toString();
            selectedCapacityId = AppConstants.getAllMachineCapacitesModel!.data[0].id.toString();
            capacityList.add(element.name.toString());

            selectedCapacity2 = AppConstants.getAllMachineCapacitesModel!.data[0].name.toString();
            selectedCapacityId2 = AppConstants.getAllMachineCapacitesModel!.data[0].id.toString();
            capacityList2.add(element.name.toString());

            selectedCapacity3 = AppConstants.getAllMachineCapacitesModel!.data[0].name.toString();
            selectedCapacityId3 = AppConstants.getAllMachineCapacitesModel!.data[0].id.toString();
            capacityList3.add(element.name.toString());
          });
          programChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    fetchDatChk=false;
    notifyListeners();
  }
  getAllItems(BuildContext context)async{
    try{
      programChk=true;
        notifyListeners();
          var response=await userWashCycleService.getAllItems(context: context,machineChk: machinesChk);
          if(response!=null){
            productList=[];
            AppConstants.getAllItemsModel=response;
            AppConstants.getAllItemsModel!.data.forEach((element) {

            selectedProduct = AppConstants.getAllItemsModel!.data[0].name.toString();
            selectedProductId= AppConstants.getAllItemsModel!.data[0].id.toString();
            productList.add(element.name.toString());
          });
          programChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    fetchDatChk=false;
    notifyListeners();
  }


  getAllBookings(BuildContext context)async{
    try{
      programChk=true;
        notifyListeners();
          var response=await UserGetAllBookings.userAllBookings(context: context,);
          if(response!=null){
          AppConstants.userGetAllBookingsModel=response;
          programChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    fetchDatChk=false;
    notifyListeners();
  }
updateSpeciBookings(BuildContext context,String id,String status)async{
    try{
          var response=await UserGetAllBookings.updateBooking(context: context,id: id,status: status);
          if(response){
            getAllBookings(context);
                ScaffoldMessenger.of(context).showSnackBar(appSnackBar('Bookings ${status}  Successfully'));
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    fetchDatChk=false;
    notifyListeners();
  }

  roundInc(BuildContext context){
    if(round==4){
      ScaffoldMessenger.of(context).showSnackBar( appSnackBar("Round must be less than 4")); 
    }
    else{
    round++;
    }
    notifyListeners();
  }
  roundDec(BuildContext context){
    if(round==1){
      ScaffoldMessenger.of(context).showSnackBar(appSnackBar("Round must be Greater than 1"));
    }
    else{
    round--;
    } 
    notifyListeners();
  }
  distanceInc(){
    distance++;
    notifyListeners();
  }
  distanceDec(BuildContext context){
    if(distance==1){
      ScaffoldMessenger.of(context).showSnackBar(appSnackBar("Distance must be Greater than 1"));
    }
    else{
      distance--;
    }
    notifyListeners();
  }


  productQuantityInc(){
    productQuantity++;
    notifyListeners();
  }
  productQuantityDec(BuildContext context){
    if(productQuantity==1){
      ScaffoldMessenger.of(context).showSnackBar(appSnackBar("product Quantity must be Greater than 1"));
    }
    else{
      productQuantity--;
    }
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
        selectedTime = picked;
        print(selectedTime.toString());
        notifyListeners();
    }
    notifyListeners();
  }
   Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
        selectedDate = picked;
    }
    notifyListeners();
  }

  String getCombinedDateTime() {
    final DateTime combined = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    
    // Convert to ISO 8601 string with UTC 'Z' suffix
    return combined.toIso8601String() + 'Z';
  }





  //getBooking Code
  DateTime newStartDateTime=DateTime.now();
  DateTime newEndDateTime=DateTime.now(); 
  int minutes=0;
  int seconds=0;
  Color col=Colors.green;
  bool popChk=false;
  Duration remainingTime = Duration.zero;

  // Method to initialize booking details and timers
   void initializeBookingDetails(int index) {
    var booking = AppConstants.userGetAllBookingsModel!.data[index];
    DateTime originalDateTime = booking.date;
    String startTime = booking.startTime;
    String endTime = booking.endTime;

    int year = originalDateTime.year;
    int month = originalDateTime.month;
    int day = originalDateTime.day;

    DateFormat timeFormat = DateFormat('HH:mm');
    DateTime parsedStartTime = timeFormat.parse(startTime);
    DateTime parsedEndTime = timeFormat.parse(endTime);

    newStartDateTime = DateTime(year, month, day, parsedStartTime.hour, parsedStartTime.minute);
    newEndDateTime = DateTime(year, month, day, parsedEndTime.hour, parsedEndTime.minute);
  }

  String buildCounterText(int index) {
    DateTime now = DateTime.now();
    initializeBookingDetails(index);

      if (now.isAfter(newStartDateTime) && now.isBefore(newEndDateTime)) {
        return "Present";
      } else if (newEndDateTime.isAfter(now)) {
        return "Future";
      } else {
        return "Past";
      }
  }

  String getRemainingTime(BuildContext context, int index) {
    DateTime now = DateTime.now();
    initializeBookingDetails(index);
var bookingDone = AppConstants.userGetAllBookingsModel!.data[index];
      remainingTime = newEndDateTime.difference(now);
      if (remainingTime.isNegative) {
        return "0 minutes";
      } else {
        minutes = remainingTime.inMinutes;
        int seconds = remainingTime.inSeconds % 60;
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (minutes > 0) {
          minutes--;
          seconds--;
          notifyListeners();
          
        }
        else {
          
        // updateSpeciBookings(context,index.toString(),"Completed");
          
          timer.cancel();
          notifyListeners();
        }
      });
      if(minutes==0 && seconds==00){
        popChk=true;
        String id=bookingDone.id.toString();
        updateSpeciBookings(context,id,"Completed");
        alert2="Your booking is done";
        notifyListeners();
      }
      // if(minutes==10 && seconds==00){
      //   popChk=true;
      //   notifyListeners();
      //   col=AppColors.redColor;
      //   notifyListeners();
      // }else{
      //   col=Colors.green;
      //   alert=null;
      //   notifyListeners();
      // }
    
        return "$minutes:${seconds.toString().padLeft(2, '0')}min Left ";
      }
    
  }
  
removeAlert(){
  popChk=!popChk;
  
  notifyListeners();
}
  String convertTo12HourFormat(String time24) {
    DateTime dateTime = DateFormat("HH:mm").parse(time24);
    return DateFormat("hh:mm a").format(dateTime);
  }

}