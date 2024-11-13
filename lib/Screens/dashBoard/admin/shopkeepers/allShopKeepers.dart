import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonCard.dart';
import 'package:fyplms/Components/commonSearchBar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/shopKeeperProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class allShopKeepers extends StatefulWidget {
  const allShopKeepers({super.key});

  @override
  State<allShopKeepers> createState() => _allShopKeepersState();
}

class _allShopKeepersState extends State<allShopKeepers> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    var branchesP = Provider.of<shopKeeperProvider>(context, listen: false);
    branchesP.getAllShopKeeper(context);
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 90),
          child:  CommonAppBar(
                title: "Admin",
          ), 
    ),
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child:Consumer<shopKeeperProvider>(builder: (context,provider,child){
        return provider.shopKeeperLoadChk?Center(
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
                  MaterialPageRoute(builder: (context) => dashBoardScreen()),
        );
                },
                child: Icon(Icons.arrow_back_outlined)),12.sw,
              commonText(text: "Retailer ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
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
                    provider.searchlist =  AppConstants.getShopKeeperModel!.data
                        .where((element) => element.name
                            .toString()
                            .toLowerCase()
                            .contains(value.toString().toLowerCase()))
                        .toList();
                    provider.hitupdate();
                  },),
            20.sh,
            provider.search.text.isEmpty?
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:AppConstants.getShopKeeperModel!.data.length,
              itemBuilder: (context,index){
                return  Column(
                  children: [
                    commonCard(
                      delIconChk: true,
                      context: context, imag: ImagePath.userLogo, title: AppConstants.getShopKeeperModel!.data[index].name.toString(), button1Text: "Details",
                    button1Click: (){
                      provider.detailEditChk(true);
                      provider.getSpecificShoopKeeper(
                      AppConstants.getShopKeeperModel!.data[index].id.toString(),
                      AppConstants.getShopKeeperModel!.data[index].name.toString(),
                      AppConstants.getShopKeeperModel!.data[index].email.toString(),
                      AppConstants.getShopKeeperModel!.data[index].phoneNumber.toString(),
                      AppConstants.getShopKeeperModel!.data[index].branchId.toString(),context);
                    },
                    delIconClick: (){
                showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                      icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                      title: Text('Deletion Confirm'),
                      content: Text('Do you want to delete this Retailer ?'),
                      actions: <Widget>[
                        TextButton(
                      onPressed: () { 
                      provider.delShopKeeper(AppConstants.getShopKeeperModel!.data[index].id.toString(), context);
                      Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                      ),
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                      ),
                    ],
                  );
                },);},
                editIconClick: (){
                  provider.detailEditChk(false);
                      provider.getSpecificShoopKeeper(
                      AppConstants.getShopKeeperModel!.data[index].id.toString(),
                      AppConstants.getShopKeeperModel!.data[index].name.toString(),
                      AppConstants.getShopKeeperModel!.data[index].email.toString(),
                      AppConstants.getShopKeeperModel!.data[index].phoneNumber.toString(),
                      AppConstants.getShopKeeperModel!.data[index].branchId.toString(),context);
                    
                                  }),
                                  20.sh,
                  ],
                );
              },
            
            ):provider.search.text.isNotEmpty?
              ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:provider.searchlist.length,
              itemBuilder: (context,index){
                return  Column(
                  children: [
                    commonCard(
                      delIconChk: true,
                      context: context, imag: ImagePath.userLogo, title: provider.searchlist![index].name.toString(), button1Text: "Details",
                    button1Click: (){
                      provider.detailEditChk(true);
                      provider.getSpecificShoopKeeper(
                      provider.searchlist![index].id.toString(),
                      provider.searchlist![index].name.toString(),
                      provider.searchlist![index].email.toString(),
                      provider.searchlist![index].phoneNumber.toString(),
                      provider.searchlist![index].branchId.toString(),context);
                    },
                    delIconClick: (){
                showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                      icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                      title: Text('Deletion Confirm'),
                      content: Text('Do you want to delete this Retailer ?'),
                      actions: <Widget>[
                        TextButton(
                      onPressed: () { 
                      provider.delShopKeeper(provider.searchlist![index].id.toString(), context);
                      Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                      ),
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                      ),
                    ],
                  );
                },);},
                editIconClick: (){
                  provider.detailEditChk(false);
                      provider.getSpecificShoopKeeper(
                      provider.searchlist![index].id.toString(),
                      provider.searchlist![index].name.toString(),
                      provider.searchlist![index].email.toString(),
                      provider.searchlist![index].phoneNumber.toString(),
                      provider.searchlist![index].branchId.toString(),context);
                                  }),
                                  20.sh,
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