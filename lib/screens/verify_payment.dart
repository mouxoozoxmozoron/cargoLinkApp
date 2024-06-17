import 'dart:ffi';
import 'dart:io';

import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/requests/action/order_payment.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/componnent/safe_button.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Verifypayment extends StatefulWidget {
  const Verifypayment({super.key});

  @override
  State<Verifypayment> createState() => _VerifypaymentState();
}

class _VerifypaymentState extends State<Verifypayment> {
  @override
  void initState() {
    super.initState();
  }

  final int orderId = Get.arguments as int;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _image;

  bool isverifying = false;
  bool isImageSelected = false;

  placeOrderlogic() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isverifying = true;
      });

      File? imageFile;
      if (_image != null) {
        imageFile = File(_image!.path);
      }

      File? receiptimage = imageFile;

      try {
        ApiResponse response = await verifypayment(
          context,
          receiptimage,
          orderId,
        );

        if (response.error == null) {
          setState(() {
            isverifying = false;
          });
          print(response.error);
          Get.back();
        } else {
          setState(() {
            isverifying = false;
          });
          print(response.error);
        }
      } catch (e) {
        warningToast("Something went wrong $e");
        print("error $e");
      }
    }
    setState(() {
      isverifying = false;
    });
  }

  void _checkPermissionAndPickImage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (status.isGranted) {
      _pickImage();
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
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
                    Icons.receipt_long,
                    size: 80,
                    color: Colors.pink,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  _image != null
                      ? Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(_image!.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: _checkPermissionAndPickImage,
                          child: const Text(
                            'upload receipt image',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),

                  const SizedBox(
                    height: 30,
                  ),

                  isverifying
                      ? const CircularProgressIndicator()
                      : SafeButton(
                          onTap: () {
                            if (_image == null) {
                              errorToast('payment receipt is required');
                            } else {
                              placeOrderlogic();
                            }
                          },
                          buttonText: 'veriffy',
                        ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    thickness: 01,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
