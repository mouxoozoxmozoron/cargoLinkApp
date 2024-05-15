import 'package:cargolink/navigations/routes_configurations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _gotoHome();
  }

  _gotoHome() async {
    await Future.delayed(const Duration(milliseconds: 2000));

    // ignore: use_build_context_synchronously
    Get.offAllNamed(RoutesClass.gethomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/cargo_logo.jpg',
            fit: BoxFit.cover,
          ),
          // Content on top of the background image
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.red,
                  backgroundImage: AssetImage('assets/cargo_logo.jpg'),
                ),
                SizedBox(height: 20),
                Text(
                  'CargoLink',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
