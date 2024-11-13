import 'package:flutter/material.dart';
import 'package:fyplms/Services/dashBoard/userAllBookingService.dart';
import 'package:fyplms/Utils/AppConstants.dart';

class UserOfferProvider with ChangeNotifier{
  bool offerScreenChk=false;

  userGetAllOffers(BuildContext context,bool chk)async{
    try{
        offerScreenChk=true;
        notifyListeners();
          var response=await UserGetAllBookings.userAllOffers(context: context,chk: chk);
          if(response!=null){
      if(response!=null){
        AppConstants.userGetAllOffersModel=response;
          offerScreenChk=false;
          notifyListeners();
          }
          offerScreenChk=false;
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }

}