import 'package:cargolink/navigations/routes_configurations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> authPage(
    String targetRoute, Map<String, dynamic>? arguments) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token != null) {
    Get.toNamed(targetRoute, arguments: arguments);
  } else {
    Get.toNamed(RoutesClass.getloginRoute(), arguments: {
      'targetRoute': targetRoute,
      'arguments': arguments,
    });
    // Get.toNamed(RoutesClass.getloginRoute(), arguments: targetRoute);
  }
}
