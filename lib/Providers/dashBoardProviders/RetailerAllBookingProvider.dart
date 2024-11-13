import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Services/dashBoard/userAllBookingService.dart';
import 'package:fyplms/Utils/AppConstants.dart';

class RetailerAllBookingProvider with ChangeNotifier{
  bool bookingChk=false;
  TextEditingController search = TextEditingController();
  dynamic searchlist = [];

  hitupdate() {
    notifyListeners();
  }  
  clearInputData(){
    notifyListeners();
  }
  getAllBookings(BuildContext context)async{
try{
        bookingChk=true;
        notifyListeners();
          var response=await UserGetAllBookings.retailerAllBookings(context: context);
          if(response!=null){
      if(response!=null){
        AppConstants.retailerAllBookingsModel=response;
          bookingChk=false;
          notifyListeners();
          }
          bookingChk=false;
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }
  updateSpeciBookings(BuildContext context,String id,String status)async{
    try{
          var response=await UserGetAllBookings.retailerUpdateBooking(context: context,id: id,status: status);
          if(response){
            getAllBookings(context);
                ScaffoldMessenger.of(context).showSnackBar(appSnackBar("Bookings Update Successfully"));
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    notifyListeners();
  }
}