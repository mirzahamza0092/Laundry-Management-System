import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonCard.dart';
import 'package:fyplms/Components/commonSearchBar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Screens/dashBoard/admin/branches/branchesDetails.dart';
import 'package:fyplms/Screens/dashBoard/admin/dashboardScreen.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class allBranchScreen extends StatefulWidget {
  const allBranchScreen({super.key});

  @override
  State<allBranchScreen> createState() => _allBranchScreenState();
}

class _allBranchScreenState extends State<allBranchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    var branchesP = Provider.of<branchesProvider>(context, listen: false);
    branchesP.getAllBranches(context);
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
        child:  Consumer<branchesProvider>(builder: (context,provider,child){
        return provider.branchLoadChk?
        Center(child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: CircularProgressIndicator(),
        ),): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.sh,
          Row(
            children: [
              InkWell(
                onTap: (){
                  provider.clearInputData();
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => dashBoardScreen()),
        );
                },
                child: Icon(Icons.arrow_back_outlined)),12.sw,
              commonText(text: "Branches  ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
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
                    provider.searchlist =  AppConstants.getBranchModel!.data
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
              itemCount: provider.allBranchesRes!.data.length,
              itemBuilder: (context,index){
                return  Column(
                  children: [
                    provider.branchLoadChk?CircularProgressIndicator():
                    commonCard(
                      delIconChk: true,
                      context: context, 
                      imag: ImagePath.branchIcon,
                      title: provider.allBranchesRes!.data[index].name.toString(), 
                      button1Text: "Details",
                      button1Click: (){
                        provider.detailEditChk(true);
                  provider.getSpecificBranch(
                        provider.allBranchesRes!.data[index].id.toString(),
                        provider.allBranchesRes!.data[index].name.toString(),
                        provider.allBranchesRes!.data[index].latitude.toString(),
                        provider.allBranchesRes!.data[index].longitude.toString(),
                        context);                      
                      },
                      delIconClick: (){
                          showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                      icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                      title: Text('Deletion Confirm'),
                      content: Text('Do you want to delete this branch?'),
                      actions: <Widget>[
                        TextButton(
                      onPressed: () { 
                      provider.delBranch(provider.allBranchesRes!.data[index].id.toString(), context);
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
                },);           
                                  },
                      editIconClick: (){
                      provider.detailEditChk(false);
                      provider.getSpecificBranch(
                        provider.allBranchesRes!.data[index].id.toString(),
                        provider.allBranchesRes!.data[index].name.toString(),
                        provider.allBranchesRes!.data[index].latitude.toString(),
                        provider.allBranchesRes!.data[index].longitude.toString(),
                        context);

                                  }),
                  20.sh,
                  ],
                );
              },
            
            ):provider.search.text.isNotEmpty?
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.searchlist.length,
              itemBuilder: (context,index){
                return  Column(
                  children: [
                    provider.branchLoadChk?CircularProgressIndicator():
                    commonCard(
                      delIconChk: true,
                      context: context, 
                      imag: ImagePath.branchIcon,
                      title: provider.searchlist![index].name.toString(), 
                      button1Text: "Details",
                      button1Click: (){
                        provider.detailEditChk(true);
                        provider.getSpecificBranch(
                        provider.searchlist![index].id.toString(),
                        provider.searchlist![index].name.toString(),
                        provider.searchlist![index].latitude.toString(),
                        provider.searchlist![index].longitude.toString(),
                        context);                      
                      },
                      delIconClick: (){
                          showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                  icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                  title: Text('Deletion Confirm'),
                  content: Text('Do you want to delete this branch?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                      provider.delBranch(provider.allBranchesRes!.data[index].id.toString(), context);
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
                },);           
                                  },
                      editIconClick: (){
                      provider.detailEditChk(false);
                      provider.getSpecificBranch(
                        provider.searchlist![index].id.toString(),
                        provider.searchlist![index].name.toString(),
                        provider.searchlist![index].latitude.toString(),
                        provider.searchlist![index].longitude.toString(),
                        context);

                                  }),
                  20.sh,
                  ],
                );
              },
            
            ):
            commonText(
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