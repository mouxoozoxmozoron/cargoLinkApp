import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/APIV1/requests/action/custommer_order_request.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/constants/common_styles.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:cargolink/models/cutommer_order_model.dart';
import 'package:cargolink/navigations/routes_configurations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Orderdisplay extends StatefulWidget {
  const Orderdisplay({super.key});

  @override
  State<Orderdisplay> createState() => _OrderdisplayState();
}

class _OrderdisplayState extends State<Orderdisplay> {
  List<Order> custorderdata = [];
  CustommerOrder? custommerOrder;
  bool isPending = true;
  bool isinPositioned = false;
  bool isDerivered = false;
  bool isreceved = false;

  @override
  void initState() {
    super.initState();
    getcustommerOrder();
  }

//STATE OF EACH ORDER
  void setOrderstate() {
    // Assume initially that the order is pending
    bool pending = true;
    bool postioned = false;
    bool received = false;
    bool delivered = false;

    // Iterate over each order in custorderdata
    for (var order in custorderdata) {
      // If receiptImage is available for any order, set pending to false and exit the loop
      if (order.receiptImage != null) {
        pending = false;
        break;
      }
      if (order.status == '1') {
        break;
      }
      if (order.position == '1') {
        delivered = true;
        break;
      }
    }

    // Set the state of isPending based on the result
    setState(() {
      isPending = pending;
      isinPositioned = postioned;
      isDerivered = delivered;
      isreceved = received;
    });
  }

  void getcustommerOrder() async {
    print("im trying to fetch your order");
    try {
      ApiResponse response = await Getcustomerorderrequest.getcustomerorder();

      if (response.error == null) {
        setState(() {
          custommerOrder = response.data as CustommerOrder;
          custorderdata = custommerOrder?.order ?? [];
        });
        successToast("Data available");
        // print('Company Name: ${company!.transportationCompanies![0].name}');
      } else {
        warningToast("No order found !");
        print(
            "API Error: ${response.error}"); // Print the specific error message
      }
    } catch (e) {
      errorToast("An error occurred while fetching data !");
      print(
          "Exception: $e"); // Print any exceptions that occur during the API request
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Manage your order",
              style: subtitleStyle,
              textAlign: TextAlign.left,
            ),
            if (custorderdata != null)
              for (var custorder in custorderdata)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Card(
                      child: Row(
                        children: [
                          Image.network(
                            // ignore: prefer_interpolation_to_compose_strings
                            baseUrl +
                                "storage/${custorder.cargoImage ?? "N/A"}",
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Text(
                                'By ${custorder.transportationCompany?.name ?? "N/A"}',
                                style: detailsStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'To ${custorder.destination ?? "N/A"}',
                                style: detailsStyle,
                              ),
                              Row(
                                children: [
                                  // Render pending icon if customerorder.status == 1, otherwise render done icon
                                  custorder.status == '0'
                                      ? const Icon(
                                          Icons.pending_actions_rounded)
                                      : const Icon(Icons.done),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  if (custorder.position == '0' &&
                                      custorder.status == '1')
                                    const Icon(
                                      Icons.countertops_outlined,
                                      color: Colors.green,
                                    ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  // Render done_all icon if customerorder.position == 1
                                  if (custorder.position == '1')
                                    const Icon(
                                      Icons.done_all,
                                      color: Colors.green,
                                    ),
                                  // Render pay button if customerorder.receipt_image is empty
                                  if (custorder.receiptImage == null ||
                                      custorder.receiptImage!.isEmpty)
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            RoutesClass.getverifypaymentRoute(),
                                            arguments: custorder.id);
                                      },
                                      child: const Text(
                                        "pay",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            else
              const Text(
                'No orders found',
                style: subtitleStyle,
              ),
          ],
        ),
      ),
    );
  }
}
