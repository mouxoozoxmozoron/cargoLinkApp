import 'dart:ffi';

import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/APIV1/requests/home/home_request.dart';
import 'package:cargolink/componnent/authpage.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:cargolink/constants/common_styles.dart';
import 'package:cargolink/models/home_model.dart';
import 'package:cargolink/navigations/routes_configurations.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

@override
final TextEditingController value = TextEditingController();
// Company? company;
Company? company;
List<TransportationCompany> filteredCompanies = [];
List companies = [];
bool isSearching = false;
bool homeLoading = true;
bool isdisplayingdetails = false;

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _gethomedata();
  }

  Future<void> filterCompanies(value) async {
    setState(() {
      if (value.isNotEmpty) {
        filteredCompanies = company?.transportationCompanies
                ?.where((transportationCompany) =>
                    transportationCompany.name
                        ?.toLowerCase()
                        .contains(value.toLowerCase()) ??
                    false)
                .toList() ??
            [];
      } else {
        // If the search value is empty, show all companies
        filteredCompanies = company?.transportationCompanies ?? [];
      }
    });
  }

// ignore: unused_element
  void _gethomedata() async {
    try {
      ApiResponse response = await Getcompaniesrequest.getCompanies();

      if (response.error == null) {
        setState(() {
          company = response.data as Company;
          filteredCompanies = company?.transportationCompanies ?? [];
          homeLoading = false;
        });
        successToast("Data available");
        print('Company Name: ${company!.transportationCompanies![0].name}');
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
      //side bar with custom clas
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text("CargoLink"),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        // ignore: prefer_const_constructors
        icon: Icon(Icons.shopping_cart_checkout_outlined),
        label: const Text(
          "12",
          // ignore: deprecated_member_use
          textScaleFactor: 1,
        ),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              //handle on change of the search section
              onChanged: (value) {
                filterCompanies(value);
                setState(() {
                  isSearching = true;
                });
              },
              controller: value,
              decoration: InputDecoration(
                  hintText: "Search your favorite agent",
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  //border
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Color.fromARGB(255, 230, 230, 230),
                    ),
                  ),

                  //on focus
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 166, 175, 183), width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  suffixIcon: isSearching
                      ? IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              // Clear the search query and reset the search state
                              value.clear();
                              filterCompanies('');
                              isSearching = false;
                              //resert to default list
                              filteredCompanies =
                                  company?.transportationCompanies ?? [];
                            });
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              // Clear the search query and reset the search state
                              value.clear();
                              filterCompanies('');
                              isSearching = false;
                            });
                          },
                        )),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
//home content

          //home content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 100,
                  ),
                  child: Column(
                    children: [
                      //loop start here
                      if (filteredCompanies != null)
                        for (var transportationCompany in filteredCompanies)

                          // ignore: avoid_unnecessary_containers
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  baseUrl +
                                      "storage/${transportationCompany.agentLogo ?? "N/A"}",
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                const Text(
                                  'agent details',
                                  style: subtitleStyle,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  'Company Name: ${transportationCompany.name ?? "N/A"}',
                                  style: detailsStyle,
                                ),
                                Text(
                                  'Category: ${transportationCompany.companyCategory ?? "N/A"}',
                                  style: detailsStyle,
                                ),
                                // Text(
                                //     'Manager Name: ${transportationCompany.user?.firstName ?? "N/A"} ${transportationCompany.user?.lastName ?? ""}'),

                                Visibility(
                                  visible: isdisplayingdetails,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Working Days: ${transportationCompany.workingDay ?? "N/A"}',
                                        style: detailsStyle,
                                      ),
                                      Text(
                                        'Contact us via : ${transportationCompany.contact ?? "N/A"} or ${transportationCompany.email ?? "N/A"}',
                                        style: detailsStyle,
                                      ),
                                      Text(
                                        'Routes: ${transportationCompany.routes ?? "N/A"}',
                                        style: detailsStyle,
                                      ),
                                      Text(
                                        'Location: ${transportationCompany.location ?? "N/A"}',
                                        style: detailsStyle,
                                      ),
                                      Text(
                                        'Payment Methos: ${transportationCompany.bankAcountNumber ?? "N/A"}',
                                        style: detailsStyle,
                                      ),
                                      Text(
                                        'Bank Type: ${transportationCompany.bankType ?? "N/A"}',
                                        style: detailsStyle,
                                      ),
                                      const Divider(),
                                      const Text(
                                        'agent manager',
                                        style: subtitleStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          'Name: ${transportationCompany.user?.firstName ?? "N/A"} ${transportationCompany.user?.lastName ?? ""}',
                                          style: detailsStyle),
                                      Text(
                                        'Contact: ${transportationCompany.user?.phoneNumber ?? "N/A"}',
                                        style: detailsStyle,
                                      ),
                                    ],
                                  ),
                                ),

                                const Divider(),

                                //action on company start here
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        authPage(
                                          RoutesClass.getplaceorderRoute(),
                                          {
                                            'companyName':
                                                transportationCompany.name ??
                                                    "N/A",
                                            'companyId':
                                                transportationCompany.id ?? -1,
                                          },
                                        );
                                      },
                                      child: const Text('place order'),
                                    ),

                                    //more about a company
                                    isdisplayingdetails
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isdisplayingdetails = false;
                                              });
                                            },
                                            icon: const Icon(Icons.expand_less),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isdisplayingdetails = true;
                                              });
                                            },
                                            icon: const Icon(Icons.expand_more),
                                          ),
                                  ],
                                ),
                                Divider(),
                                const SizedBox(
                                  height: 10,
                                ),

                                //action on company
                              ],
                            ),
                          ),

                      if (filteredCompanies.isEmpty)
                        const Text(
                          'No agencies found',
                        ),

                      if (company == null)
                        const Text(
                          'Loading...',
                        ),

                      // Add more widgets here if needed
                    ],
                  ),
                ),
              ),
            ),
          ),
          //end of home content

//end of home content
        ],
      ),
    );
  }
}





                         // Navigator.pushNamed(
                                        //   context,
                                        //   RoutesClass.getplaceorderRoute(),
                                        //   arguments: {
                                        //     'companyName':
                                        //         transportationCompany.name ??
                                        //             "N/A",
                                        //     'companyId':
                                        //         transportationCompany.id ?? -1,
                                        //   },
                                        // );