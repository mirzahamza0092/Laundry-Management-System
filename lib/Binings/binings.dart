import 'package:fyplms/Providers/AuthProvider/addUserProvider.dart';
import 'package:fyplms/Providers/AuthProvider/loginProvider.dart';
import 'package:fyplms/Providers/AuthProvider/setPasswordProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/RetailerAllBookingProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/branchesProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/bulkRequestProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/chargesProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/machineProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/productProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/shopKeeperProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/userDashboardProvider.dart';
import 'package:fyplms/Providers/dashBoardProviders/userOfferProvider.dart';
import 'package:provider/provider.dart';

var Bingings = [
  ChangeNotifierProvider<loginProvider>(
    create: (context) => loginProvider(),
  ),
  ChangeNotifierProvider<addUserProvider>(
    create: (context) => addUserProvider(),
  ),
  ChangeNotifierProvider<setPasswordProvider>(
    create: (context) => setPasswordProvider(),
  ),
  ChangeNotifierProvider<branchesProvider>(
    create: (context) => branchesProvider(),
  ),
  ChangeNotifierProvider<shopKeeperProvider>(
    create: (context) => shopKeeperProvider(),
  ),
  ChangeNotifierProvider<UserDashbardProvider>(
    create: (context) => UserDashbardProvider(),
  ),
  ChangeNotifierProvider<MachineProvider>(
    create: (context) => MachineProvider(),
  ),
  ChangeNotifierProvider<RetailerAllBookingProvider>(
    create: (context) => RetailerAllBookingProvider(),
  ),
  ChangeNotifierProvider<ProductsProvider>(
    create: (context) => ProductsProvider(),
  ),
  ChangeNotifierProvider<ChargesProvider>(
    create: (context) => ChargesProvider(),
  ),
  ChangeNotifierProvider<UserOfferProvider>(
    create: (context) => UserOfferProvider(),
  ),
  ChangeNotifierProvider<BulkRequestProvider>(
    create: (context) => BulkRequestProvider(),
  ),
];