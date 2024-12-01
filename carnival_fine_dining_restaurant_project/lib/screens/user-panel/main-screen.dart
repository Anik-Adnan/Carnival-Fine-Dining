


import 'package:get/get.dart';

import '../../custom_widgets/all_food_items_widget.dart';
import '../../custom_widgets/banner-widget.dart';
import '../../custom_widgets/food_categories_widget.dart';
import '../../custom_widgets/user_drawer_widget.dart';
import '../../custom_widgets/flashSale-widget.dart';
import '../../custom_widgets/heading-widget.dart';
import '../../services/get_server_key.dart';
import '../../services/notification_service.dart';
import '/utils/app_constant.dart';
import 'package:flutter/material.dart';

import 'all_food_category_screen.dart';
import 'all-flashSale-product-screen.dart';
import 'all_food_items_screen.dart';
import 'cart_screen.dart';
import 'notification_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  NotificationService notificationService = NotificationService();
  final GetServerKey _getServerKey = GetServerKey();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotification();
    notificationService.getDeviceToken();
    // FcmService.firebaseInit();

    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appName),
        actions:  [
          GestureDetector(
            onTap: ()=> {
              Get.to(()=> NotificationScreen()),
              // EasyLoading.show();
              // await SendNotificationService.sendNotificationUsingApi(
              //   token: await notificationService.getDeviceToken(),
              //     title: "Order Created Successfully",
              //     body: "Product Name: N/A",
              //     data: {
              //       'screen': 'order',
              //     });
              //   EasyLoading.dismiss();
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.notifications,color: Colors.black,)),
          ),
          GestureDetector(
            onTap: () async {
              Get.to(CartScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart,color: Colors.black,)),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height/95.0
              ),
              BannerWidget(),

              HeadingWidget(
                headingTitle: "Today's Hot Deals",
                headingSubTitle: "According to your budget",
                onTap: ()=> Get.to(AllFlashSaleProductsScreen()),
                buttonText: "see more>>",
              ),
              FlashSaleWidget(),

              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your budget",
                onTap: ()=> Get.to(AllFoodCategoryScreen()),
                buttonText: "see more>>",
              ),
              FoodCategoriesWidget(),
              //
              // HeadingWidget(
              //   headingTitle: "All Products",
              //   headingSubTitle: "According to your budget",
              //   onTap: () =>Get.to(AllFoodItemsScreen()),
              //   buttonText: "see more>>",
              // ),
              // AllFoodItemsWidget(),



            ],
          ),
        ),
      ),

    );
  }


}