import 'package:fyplms/Models/AdminDashBoardModels/branchesModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getAllLoadCapacityModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getAllProgramsModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/getshopKeeperModel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/loginScreenmodel.dart';
import 'package:fyplms/Models/AdminDashBoardModels/specificShopKeeperModel.dart';
import 'package:fyplms/Models/RetailerAllModels/getAllMachinesModel.dart';
import 'package:fyplms/Models/RetailerAllModels/getAllProductsModel.dart';
import 'package:fyplms/Models/RetailerAllModels/retailerGetAllBookingsModel.dart';
import 'package:fyplms/Models/UserAllModels/bulkGetAllBranchesModel.dart';
import 'package:fyplms/Models/UserAllModels/getAllItemsModel.dart';
import 'package:fyplms/Models/UserAllModels/getAllMachineCapacitiesModel.dart';
import 'package:fyplms/Models/UserAllModels/getMachineCycleModel.dart';
import 'package:fyplms/Models/UserAllModels/userGetAllBookingsModel.dart';
import 'package:fyplms/Models/UserAllModels/userGetAllMachineModel.dart';
import 'package:fyplms/Models/UserAllModels/userGetMachineModel.dart';
import 'package:fyplms/Models/UserAllModels/usergetAllOffersModel.dart';

class AppConstants {
  //Models 
  static BranchesModel? getBranchModel;
  static UserGetMachineModel? userGetBranchesModel;
  static GetAllShopKeeperModel? getShopKeeperModel;
  static SpecificShopKeeperModel? getSpecShopKeeperModel;
  static LoginScreenModel? loginSModel;
  static GetMachineCycleModel? getMachineCycleModel;
  static GetAllMachineCapacitesModel? getAllMachineCapacitesModel;
  static GetAllItemsModel? getAllItemsModel;
  static GetAllProgramsModel? getAllProgramModel;
  static GetAllLoadCapacityModel? getAllLoadCapacityModel;
  static GetAllMachinesModel? getAllMachinesModel;
  static GetAllProductsModel? getAllProductsModel;
  static UserGetAllMachinesModel? userGetAllMachinesModel;
  static UserGetAllBookingsModel? userGetAllBookingsModel;
  static UserGetAllOffersModel? userGetAllOffersModel;
  static RetailerAllBookingsModel? retailerAllBookingsModel;
  static BulkGetAllBranchesModel? bulkGetAllBranchesModel;


  //Common Variables
    static String token='token';
    static String apiPath="http://192.168.43.19:82/api/";
    static String ipPath="http://192.168.43.19:82/Images/";
}