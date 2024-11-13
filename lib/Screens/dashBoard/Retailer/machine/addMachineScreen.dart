import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonDropDown.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/machineProvider.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class AddMachineScreen extends StatefulWidget {
  const AddMachineScreen({super.key});

  @override
  State<AddMachineScreen> createState() => _AddMachineScreenState();
}

class _AddMachineScreenState extends State<AddMachineScreen> {
  GlobalKey<FormState> addbranchesKey=GlobalKey();
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    var machineP = Provider.of<MachineProvider>(context, listen: false);
    machineP.getAllLoadCapacities(context);
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
      child:  Consumer<MachineProvider>(builder: (context,provider,child){
                return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key:addbranchesKey ,
          child:provider.machineLoadChk?Center(child: CircularProgressIndicator(),): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.sh,
            Row(
              children: [
                InkWell(
                  onTap: (){
                    provider.clearInputData();
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => RetailerDashboard()),
          );
                  },
                  child: Icon(Icons.arrow_back_outlined)),12.sw,
                commonText(text: "Add Machine  ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
              
              ],
            ),
            20.sh,
            commonText(text: "Type ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonDropDown(width: width(context), selectedText: provider.selectedMachineType.toString(), listItem:provider.machinetypeList, onchanged: (val){
                        provider.typeChange(val,context);
                                      }),
                                      10.sh,
                commonText(text: "Machine Code", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonTextField(
                  controller: provider.machineCode,
                  hinttext: "Machine Code",
                validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Machine Code can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },),
                10.sh,
                commonText(text: "Capacity", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonDropDown(width: width(context), selectedText: provider.selectedCapacity.toString(), listItem:provider.loadCapacityList, onchanged: (val){
                        provider.loadCapacityValue(val);
                                      }),
                // 10.sh,
                // commonText(text: "Price ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                // 10.sh,
                // CommonTextField(
                //   keyboardType: TextInputType.number,
                //   controller:provider.machinePrice,
                //   hinttext: "Price",
                // validator: (value) {
                //                       if (value == null || value.isEmpty) {
                //                         return "Price can't be empty";
                //                       } else {
                //                         return null;
                //                       }
                //                     },),
                10.sh,
                commonText(text: "Status ", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                10.sh,
                CommonDropDown(width: width(context), selectedText: provider.selectedStatus.toString(), listItem:provider.statusList, onchanged: (val){
                        provider.statusChange(val);
                                      }),
                30.sh,
            // provider.addBranchChk?
            // Center(child: CircularProgressIndicator()):
           provider.machineLoadChk?Center(child: CircularProgressIndicator(),): CommonButton(onPressed: (){
          if(addbranchesKey.currentState!.validate()){
            provider.addMachine(
              provider.machineCode.text.toString(),
              provider.selectedCapacityId.toString(),
              provider.selectedMachineType.toString(),
              provider.selectedStatus.toString(),
              provider.machinePrice.text.toString(),
              context

            );
                }
                }, width: width(context), text: "Submit",color: AppColors.primaryColor,)
          ]),
        ),
      );})
    ),
    );
  }
}