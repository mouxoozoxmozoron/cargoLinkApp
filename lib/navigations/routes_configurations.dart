import 'package:cargolink/APIV1/requests/auth/logout_request.dart';
import 'package:cargolink/main.dart';
import 'package:cargolink/screens/create_comapany.dart';
import 'package:cargolink/screens/home.dart';
import 'package:cargolink/screens/login.dart';
import 'package:cargolink/screens/order.dart';
import 'package:cargolink/screens/place_order.dart';
import 'package:cargolink/splash_dcreen.dart';
import 'package:get/get.dart';

class RoutesClass {
//home
  static String home = "/";
  static String getHomeRoute() => home;

  static String splashscreen = "/splash_screen";
  static String getsplashscreenRoute() => splashscreen;

  static String login = "/login";
  static String getloginRoute() => login;

  static String agency = "/agency";
  static String gethomeRoute() => agency;

  static String register = "/register";
  static String getregisterscreenRoute() => register;

  static String createcompany = "/createcompany";
  static String getcreatecomapnyRoute() => createcompany;

  static String placeOrder = "/placeOrder";
  static String getplaceorderRoute() => placeOrder;

  static String orderlist = "/orderlist";
  static String getorderlistrRoute() => orderlist;

  static String community = "/community";
  static String getcommunityRoute() => community;

  static List<GetPage> routes = [
    GetPage(page: () => const InitHome(), name: home),
    //any other routes goes here
    GetPage(page: () => const SplashScreen(), name: splashscreen),
    GetPage(page: () => const Home(), name: agency),
    GetPage(page: () => Login(), name: login),
    GetPage(page: () => PlaceOrder(), name: placeOrder),
    GetPage(page: () => const Orderdisplay(), name: orderlist),
    GetPage(page: () => const Createcompany(), name: createcompany),
  ];
}
