import "package:cargolink/APIV1/requests/auth/logout_request.dart";
import "package:cargolink/componnent/authpage.dart";
import "package:cargolink/constants/widgets.dart";
import "package:cargolink/navigations/routes_configurations.dart";
import "package:flutter/material.dart";
import "package:get/get_navigation/get_navigation.dart";
import "package:get/utils.dart";

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Manyama Japhet'),
            accountEmail: const Text('manyama@.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/cargo_logo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: Text(
              'CargoLink',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.offAllNamed(RoutesClass.gethomeRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              warningToast('Not yet implemented');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification'),
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                height: 20,
                width: 20,
                child: const Center(
                  child: Text(
                    '10',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              warningToast('Not yet implemented');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_sharp),
            title: const Text('My Order'),
            onTap: () {
              authPage(RoutesClass.getorderlistrRoute(), {'id': ''});
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_business_sharp),
            title: const Text('New Compny'),
            onTap: () {
              // Get.toNamed(RoutesClass.getcreatecomapnyRoute());
              authPage(RoutesClass.getcreatecomapnyRoute(), {'id': ''});
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_center_outlined),
            title: const Text('My company'),
            onTap: () {
              warningToast('Not yet implemented');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              logoutPage();
            },
          ),
        ],
      ),
    );
  }
}
