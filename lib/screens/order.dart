import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/APIV1/requests/action/custommer_order_request.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/constants/common_styles.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:cargolink/models/cutommer_order_model.dart';
import 'package:flutter/material.dart';

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
        received = true;
        break;
      }
      if (order.status == 1) {
        delivered = true;
        break;
      }
      if (order.position == '1') {
        postioned = true;
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
        errorToast("Not connected !");
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
              "Mnage your order",
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
                                  isPending
                                      ? const Icon(
                                          Icons.pending_actions_rounded)
                                      : const Icon(Icons.done),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.receipt_long_outlined),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.car_rental),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  isDerivered
                                      ? const Icon(
                                          Icons.done_all,
                                          color: Colors.green,
                                        )
                                      : const SizedBox(
                                          width: 0,
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Pay",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                        ),
                                      )),
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
