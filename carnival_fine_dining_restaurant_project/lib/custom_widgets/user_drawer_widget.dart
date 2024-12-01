

import 'package:carnival_fine_dining_restaurant_project/screens/auth-ui/sigin-in-screen.dart';
import 'package:carnival_fine_dining_restaurant_project/screens/user-panel/all_food_category_screen.dart';
import 'package:carnival_fine_dining_restaurant_project/screens/user-panel/all_food_items_screen.dart';
import 'package:carnival_fine_dining_restaurant_project/screens/user-panel/cart_screen.dart';

import '../screens/user-panel/all_order_screen.dart';
import '/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/auth-ui/welcome-screen.dart';

class DrawerWidget extends StatefulWidget{
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();

}
class _DrawerWidgetState extends State<DrawerWidget>{

  final TextStyle drawerTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Wrap(
        runSpacing: 10.0,
        children: [
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("${AppConstant.appName.toString()}",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("version 1.0.1"),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appSecondaryColor,
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('B'),
                  ),
                ),

              )
          ),
          const Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 1.5,
            color: Colors.grey,
          ),
          _buildDrawerTile("Home", Icons.home, () {},drawerTextStyle),
          _buildDrawerTile("Food Categories", Icons.category, () {
            Get.back();
            Get.to(() => AllFoodCategoryScreen());
          },drawerTextStyle),
          _buildDrawerTile("Food Items", Icons.production_quantity_limits, () {
            Get.back();
            Get.to(() => AllFoodItemsScreen());
          },drawerTextStyle),
          _buildDrawerTile("Orders", Icons.bookmark_border, () {
            Get.back();
            Get.to(() => AllOrderScreen());
          },drawerTextStyle),
          _buildDrawerTile("Cart", Icons.shopping_cart, () {
            Get.back();
            Get.to(() => CartScreen());
          },drawerTextStyle),
          _buildDrawerTile("Location", Icons.location_city, () {},drawerTextStyle),
          _buildDrawerTile("Contact", Icons.help_center, () {},drawerTextStyle),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Logout",style: TextStyle(fontWeight: FontWeight.bold),),
                leading: const Icon(Icons.logout),
                onTap: () async{
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(()=> WelcomeScreen());
                },
              )
          ),
          // drawer footer logout and signIn

        ],

      ),
    );
  }

  Widget _buildDrawerTile(String title, IconData icon, VoidCallback onTap, TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(
          title,
          style: textStyle,
        ),
        leading: Icon(icon),
        onTap: onTap,
      ),
    );
  }

}