import 'package:flutter/material.dart';
import 'package:fyplms/Components/commonSnakbar.dart';
import 'package:fyplms/Screens/dashBoard/Retailer/retailerDashboardScreen.dart';
import 'package:fyplms/Services/dashBoard/productService.dart';
import 'package:fyplms/Utils/AppConstants.dart';
import 'package:image_picker/image_picker.dart';

class ProductsProvider with ChangeNotifier{
  TextEditingController productName=TextEditingController();
  TextEditingController productQuantity=TextEditingController();
  TextEditingController productPrice=TextEditingController();
  bool productLoadChk=false;
  TextEditingController search = TextEditingController();
  dynamic searchlist = [];
  String selectedMachineType="Washer";
  List<String> machinetypeList=["Washer","Dryer"];
  final ImagePicker picker = ImagePicker();
  String? imageName,imagePath;
  hitupdate() {
    notifyListeners();
  }  
  typeChange(String val){
    selectedMachineType=val;
    notifyListeners();
  }
  clearInputData(){
    productQuantity.clear();
    productName.clear();
    productPrice.clear();
    imageName="";
    notifyListeners();
  }
  getSpecificPriceAndQuantity(String price,String quantity){
    productPrice.text=price;
    productQuantity.text=quantity;
    notifyListeners();
  }
  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
        imagePath = pickedFile.path;
        print(imagePath.toString());
        imageName=pickedFile.name;
      notifyListeners();
    }
  }
  addProduct(
  String name,
  String price,
  String quantity,
  BuildContext context,)async{
try{
    productLoadChk=true;
    notifyListeners();
    var response=await ProductService.addProducts(
      name: name,
      description: "",
      machineType:selectedMachineType,
      quantity: quantity,
      img:imagePath.toString(),
      price:price,
      context: context
      );
    if(response!=null){
      clearInputData();
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Product add Successfully")); 
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => RetailerDashboard()));
      productLoadChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    productLoadChk=false;
  }
  getAllProducts(BuildContext context)async{
    try{
      productLoadChk=true;
        notifyListeners();
          var response=await ProductService.getAllProducts(context: context,);
          if(response!=null){
            AppConstants.getAllProductsModel=response;
          productLoadChk=false;
          notifyListeners();
          }
          
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    productLoadChk=false;
    notifyListeners();
  }
  delProduct(String id,BuildContext context)async{
  try{
    var response=await ProductService.delProduct(context: context,id:id);
    if(response!=null){
      getAllProducts(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Product delete Successfully")); 
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
  }
  updateProduct(
  String id,
  String name,
  String price,
  String quantity,
  String productType,
  String productImg,
  BuildContext context,)async{
try{
    productLoadChk=true;
    notifyListeners();
    var response=await ProductService.updateProduct(
      id: id,
      name: name,
      description: "",
      productType:productType,
      quntity: quantity,
      productImage:productImg,
      price:price,
      context: context
      );
    if(response!=null){
      clearInputData();
      getAllProducts(context);
      ScaffoldMessenger.of(context).showSnackBar(
                      appSnackBar("Product Update Successfully")); 
      
      productLoadChk=false;
    }
    notifyListeners();
    }catch (exception) {
      print(exception);
    }
    productLoadChk=false;
  }
}