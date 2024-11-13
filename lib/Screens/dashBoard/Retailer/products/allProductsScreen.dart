import 'package:flutter/material.dart';
import 'package:fyplms/Components/CommonTextField.dart';
import 'package:fyplms/Components/commonAppBar.dart';
import 'package:fyplms/Components/commonButton.dart';
import 'package:fyplms/Components/commonCard.dart';
import 'package:fyplms/Components/commonSearchBar.dart';
import 'package:fyplms/Components/commonText.dart';
import 'package:fyplms/Providers/dashBoardProviders/productProvider.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:fyplms/Utils/AppPath.dart';
import 'package:fyplms/Utils/Colors.dart';
import 'package:fyplms/Utils/SizedBox.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    var productP = Provider.of<ProductsProvider>(context, listen: false);
    productP.getAllProducts(context);
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
        child:Consumer<ProductsProvider>(builder: (context,provider,child){
        return provider.productLoadChk?Center(
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
                  provider.clearInputData();
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RetailerDashboard()),
        );
                },
                child: Icon(Icons.arrow_back_outlined)),12.sw,
              commonText(text: "All Products ", size: 18, color: AppColors.blackColor, fontweight: FontWeight.w500),
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
                    provider.searchlist =  AppConstants.getAllProductsModel!.data
                        .where((element) => 
                        element.name.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.price.toString().toLowerCase().contains(value.toString().toLowerCase())||
                        element.productType.toString().toLowerCase().contains(value.toString().toLowerCase())
                        )
                        .toList();
                    provider.hitupdate();
                  },),
            20.sh,
            provider.search.text.isEmpty?
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:AppConstants.getAllProductsModel!.data.length,
              itemBuilder: (context,index){
              //String? imgPath=  '${AppConstants.ipPath}${AppConstants.getAllProductsModel!.data[index].productImageUrl.toString()}';
                return  Column(
                  children: [
                    commonCard(
                      delIconChk: true,
                      context: context, imag: ImagePath.productsIcon, title: AppConstants.getAllProductsModel!.data[index].name.toString(),
                      button1Text: "Update",
                      detailChk: true,
                      title1:'Price: ${AppConstants.getAllProductsModel!.data[index].price.toString()} Rs',
                      title2: 'Quantity: ${AppConstants.getAllProductsModel!.data[index].quantity.toString()}',
                      title3: 'Type: ${AppConstants.getAllProductsModel!.data[index].productType.toString()}',
                    button1Click: (){
                      provider.getSpecificPriceAndQuantity(AppConstants.getAllProductsModel!.data[index].price.toString(),AppConstants.getAllProductsModel!.data[index].quantity.toString());
                      showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                    title:commonText(text: "Update Product", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  actions: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                      5.sh,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        hinttext: "Product Price",
                        keyboardType: TextInputType.number,
                        controller:provider.productPrice ,
                      ),
                    ),
                    5.sh,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: commonText(text: "Quantity", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                      5.sh,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        hinttext: "Product Quantity",
                        keyboardType: TextInputType.number,
                        controller:provider.productQuantity ,
                      ),
                    ),
                    
                    10.sh,
                    Center(
                      child: CommonButton(onPressed: (){
                        provider.updateProduct(
                          AppConstants.getAllProductsModel!.data[index].id.toString(), 
                          AppConstants.getAllProductsModel!.data[index].name.toString(), 
                          provider.productPrice.text.toString(), 
                          provider.productQuantity.text.toString(), 
                          AppConstants.getAllProductsModel!.data[index].productType.toString(), 
                          AppConstants.getAllProductsModel!.data[index].productImageUrl.toString(), 
                          context);
                          Navigator.of(context).pop();
                      }, width: width(context)/2, text: "Update",color: AppColors.primaryColor,),
                    )
                    ],
                  );
                },); 
                    },
                    delIconClick: (){
                showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                      title: Text('Deletion Confirm'),
                      content: Text('Do you want to delete this Product ?'),
                      actions: <Widget>[
                        TextButton(
                      onPressed: () { 
                      provider.delProduct(AppConstants.getAllProductsModel!.data[index].id.toString(), context);
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
                },);}),
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
                      context: context, imag: ImagePath.productsIcon, title: provider.searchlist![index].name.toString(), 
                      button1Text: "Update",
                      title1:'Price: ${provider.searchlist![index].price.toString()} Rs',
                      title2: 'Quantity: ${provider.searchlist![index].quantity.toString()}',
                      title3: 'Type: ${provider.searchlist![index].productType.toString()}',
                      detailChk: true,
                    button1Click: (){
                        provider.getSpecificPriceAndQuantity(AppConstants.getAllProductsModel!.data[index].price.toString(),AppConstants.getAllProductsModel!.data[index].quantity.toString());
                      showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                    title:commonText(text: "Update Product", size: 14, color: AppColors.blackColor, fontweight: FontWeight.w500),
                  actions: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: commonText(text: "Price", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                      5.sh,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        hinttext: "Product Price",
                        keyboardType: TextInputType.number,
                        controller:provider.productPrice ,
                      ),
                    ),
                    5.sh,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: commonText(text: "Quantity", size: 12, color: AppColors.blackColor, fontweight: FontWeight.w500)),
                      5.sh,
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: CommonTextField(
                        hinttext: "Product Quantity",
                        keyboardType: TextInputType.number,
                        controller:provider.productQuantity ,
                      ),
                    ),
                    
                    10.sh,
                    Center(
                      child: CommonButton(onPressed: (){
                        provider.updateProduct(
                          provider.searchlist![index].id.toString(), 
                          provider.searchlist![index].name.toString(), 
                          provider.productPrice.text.toString(), 
                          provider.productQuantity.text.toString(), 
                          provider.searchlist![index].productType.toString(), 
                          provider.searchlist![index].productImageUrl.toString(), 
                          context);
                          Navigator.of(context).pop();
                      }, width: width(context)/2, text: "Update",color: AppColors.primaryColor,),
                    )
                    ],
                  );
                },); 
                    },
                    delIconClick: (){
                showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                      icon: Image(image:AssetImage(ImagePath.eyeIcon),width: 50,height: 50,),
                      title: Text('Deletion Confirm'),
                      content: Text('Do you want to delete this Product ?'),
                      actions: <Widget>[
                        TextButton(
                      onPressed: () { 
                      provider.delProduct(provider.searchlist![index].id.toString(), context);
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
                },);},),
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