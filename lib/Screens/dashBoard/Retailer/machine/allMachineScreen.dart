import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonCard.dart';
import 'package:fyplms/Components/commonSearchBar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/machineProvider.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class AllMachineScreen extends StatefulWidget {
  const AllMachineScreen({super.key});

  @override
  State<AllMachineScreen> createState() => _AllMachineScreenState();
}

class _AllMachineScreenState extends State<AllMachineScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    var machineP = Provider.of<MachineProvider>(context, listen: false);
    machineP.getAllMachines(context);
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
        child:Consumer<MachineProvider>(builder: (context,provider,child){
        return provider.machineLoadChk?Center(
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
              commonText(text: "Machines ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
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
                    provider.searchlist =  AppConstants.getAllMachinesModel!.data
                        .where((element) => 
                        element.machineCode.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.status.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.machineType.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.loadCapacityName.toString().toLowerCase().contains(value.toString().toLowerCase())
                        )
                      
                        .toList();
                    provider.hitupdate();
                  },),
            20.sh,
            provider.search.text.isEmpty?
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:AppConstants.getAllMachinesModel!.data.length,
              itemBuilder: (context,index){
                return  Column(
                  children: [
                    commonCard(
                      delIconChk: true,
                      context: context,
                      detailChk: true,
                      imag:AppConstants.getAllMachinesModel!.data[index].machineType.toString()=="Washer"? ImagePath.washingMachineIcon:ImagePath.DryMachineIcon, 
                      title:'Type: ${ AppConstants.getAllMachinesModel!.data[index].machineType.toString()}',
                      title1:'Code: ${ AppConstants.getAllMachinesModel!.data[index].machineCode.toString()}' ,
                      title2: 'Capacity: ${ AppConstants.getAllMachinesModel!.data[index].loadCapacityName.toString()}',
                      title3: 'Price: ${ AppConstants.getAllMachinesModel!.data[index].price.toString()}',
                      button1Text: AppConstants.getAllMachinesModel!.data[index].status.toString()=="Active"?"Block":"Un-Block",
                      color:AppConstants.getAllMachinesModel!.data[index].status.toString()=="Active"?AppColors.primaryColor:AppColors.redColor ,
                    button1Click: (){
                      String status=AppConstants.getAllMachinesModel!.data[index].status.toString()=="Active"?"Block":"Active";
                      provider.machineStatusChange(status);
                      provider.updateMachine(AppConstants.getAllMachinesModel!.data[index].id.toString(),context);
                    },
                    
                    delIconClick: (){
                showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                      icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                      title: Text('Deletion Confirm'),
                      content: Text('Do you want to delete this Machine ?'),
                      actions: <Widget>[
                        TextButton(
                      onPressed: () { 
                      provider.delMachine(AppConstants.getAllMachinesModel!.data[index].id.toString(), context);                      Navigator.of(context).pop();
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
                                  ),
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
                      context: context,
                      imag:provider.searchlist![index].machineType.toString()=="Washer"? ImagePath.washingMachineIcon:ImagePath.DryMachineIcon, 
                      title:'Type: ${ provider.searchlist![index].machineType.toString()}',
                      title1:'Code: ${ provider.searchlist![index].machineCode.toString()}' ,
                      title2: 'Capacity: ${ provider.searchlist![index].loadCapacityName.toString()}',
                      title3: 'Price: ${ provider.searchlist![index].price.toString()}',
                      color:provider.searchlist![index].status.toString()=="Active"?AppColors.primaryColor:AppColors.redColor ,
                      button1Text: provider.searchlist![index].status.toString()=="Active"?"Block":"Un-Block",
                      detailChk: true,
                    button1Click: (){
                    
                    },
                    delIconClick: (){
                showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                      icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                      title: Text('Deletion Confirm'),
                      content: Text('Do you want to delete this Machine ?'),
                      actions: <Widget>[
                        TextButton(
                      onPressed: () { 
                      provider.delMachine(provider.searchlist![index].id.toString(), context);
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
                ),
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