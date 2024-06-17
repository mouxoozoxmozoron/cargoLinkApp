import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/requests/auth/login_request.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/componnent/safe_button.dart';
import 'package:cargolink/componnent/textfield.dart';
import 'package:cargolink/constants/common_styles.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:cargolink/models/login_model.dart';
import 'package:cargolink/navigations/routes_configurations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String userTargetedRoute;

  @override
  void initState() {
    super.initState();
    getArgs();
  }

  void getArgs() {
    final args = Get.arguments;

    if (args != null && args is Map<String, dynamic>) {
      userTargetedRoute = args['targetRoute'];
    } else {
      userTargetedRoute = RoutesClass.gethomeRoute();
      print('No arguments available');
      print(args);
    }
  }

  // final usertargetedRoute = Get.arguments as String;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLogingin = false;
  bool isReadytogo = false;

  navigateTotargeted() {
    if (isReadytogo) {
      // Check if arguments are not null before passing them
      final args = Get.arguments;
      if (args != null) {
        Get.offNamed(userTargetedRoute, arguments: args['arguments']);
      } else {
        // Handle case where arguments are null
        print('Arguments are null');
      }
    }
  }

  void signUserIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLogingin = true;
      });

      String email = emailController.text;
      String password = passwordController.text;
      print('Signing in with Email: $email, Password: $password');
      try {
        //declaring user variable
        Loginmodel? authToken;
        User? user;
        //User
        ApiResponse response = await loginrequest(context, email, password);

        if (response.error == null) {
          setState(() {
            Loginmodel loginModel = response.data as Loginmodel;

            user = loginModel.user?.first;

            authToken = response.data as Loginmodel;
          });

          final SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('token', authToken!.token!);
          await prefs.setInt('userId', user!.id!);
          await prefs.setInt('usertypeId', user!.userType!.id!);

          final token = prefs.getString('token');
          final user_id = prefs.getInt('userId');
          final usertype = prefs.getInt('usertypeId');

          print(token);
          print("loged in user id: $user_id");
          print("loged in user type: $usertype");
          setState(() {
            isReadytogo = true;
            navigateTotargeted();
          });
        }
      } catch (e) {
        // Handle error
        warningToast('Connection problem');
        print('Login failed: $e');
      }

      setState(() {
        isLogingin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  //logo
                  const Icon(
                    Icons.lock,
                    size: 80,
                    color: Colors.pink,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //text
                  const Text(
                    'Welcome back',
                    style: subtitleStyle,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  //text field
                  //email
                  Mytextfield(
                    controller: emailController,
                    hintText: "Email",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      //valid email validater logic
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      // You can add more validation rules for email format
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //password
                  Mytextfield(
                    controller: passwordController,
                    hintText: "Password",
                    obseequreText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // You can add more validation rules for email format
                      return null;
                    },
                  ),
                  //end of text fiels

                  const SizedBox(
                    height: 30,
                  ),

                  //forgot password?
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot password?",
                          style: detailsStyle,
                        ),
                      ],
                    ),
                  ),
                  //end of forgot password just for the future
                  const SizedBox(
                    height: 25,
                  ),

                  //login button
                  isLogingin
                      ? const CircularProgressIndicator()
                      : SafeButton(
                          onTap: signUserIn,
                          buttonText: 'Sign in',
                        ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    thickness: 01,
                    color: Colors.white,
                  ),

                  TextButton(
                    onPressed: () {
                      Get.toNamed(RoutesClass.getregisterscreenRoute());
                    },
                    child: const Text(
                      "Dont have an account?",
                      style: detailsStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
