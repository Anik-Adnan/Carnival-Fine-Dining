
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';

import '../../controllers/food_price_controller.dart';
import '../../models/order-model.dart';
import '../../utils/app_constant.dart';
import 'add_review_screen.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController = Get.put(ProductPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Orders found!"),
            );
          }

          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final foodItemData = snapshot.data!.docs[index];

                  OrderModel orderModel = OrderModel(
                    foodId: foodItemData['foodId'],
                    foodCategoryId: foodItemData['foodCategoryId'],
                    foodName: foodItemData['foodName'],
                    foodCategoryName: foodItemData['foodCategoryName'],
                    salePrice: foodItemData['salePrice'],
                    fullPrice: foodItemData['fullPrice'],
                    foodImages: foodItemData['foodImages'],
                    deliveryTime: foodItemData['deliveryTime'],
                    isSale: foodItemData['isSale'],
                    foodDescription: foodItemData['foodDescription'],
                    createdAt: foodItemData['createdAt'],
                    updatedAt: foodItemData['updatedAt'],
                    foodItemsQuantity: foodItemData['foodItemsQuantity'],
                    foodItemsTotalPrice: double.parse(foodItemData['foodItemsTotalPrice'].toString()),
                    customerId: foodItemData['customerId'],
                    status: foodItemData['status'],
                    customerName: foodItemData['customerName'],
                    customerPhone: foodItemData['customerPhone'],
                    customerAddress: foodItemData['customerAddress'],
                    customerDeviceToken: foodItemData['customerDeviceToken'],

                  );

                  //calculate price
                  productPriceController.fetchProductPrice();
                  return SwipeActionCell(
                    key: ObjectKey(orderModel.foodId),
                    trailingActions: [
                      SwipeAction(
                        title: "Delete",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe: true,
                        onTap: (CompletionHandler handler) async {
                          print('deleted');

                          await FirebaseFirestore.instance
                              .collection('orders')
                              .doc(user!.uid)
                              .collection('confirmOrders')
                              .doc(orderModel.foodId)
                              .delete();
                        },
                      )
                    ],
                    child: Card(
                      elevation: 5,
                      color: AppConstant.appStatusBarColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          backgroundImage:
                          NetworkImage(orderModel.foodImages[0]),
                        ),
                        title: Text(orderModel.foodName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(orderModel.foodItemsTotalPrice.toString()),
                            SizedBox(
                              width: Get.width / 20.0,
                            ),
                            orderModel.status != true ?
                            Text("Pending...", style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                                : Text("Deliverd", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        trailing: orderModel.status ==true ? ElevatedButton(
                            onPressed: () => ReviewAndRatingDialog.showReviewDialog(context, orderModel),
                            child: Text("Review"))
                            :SizedBox.shrink(),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),

    );
  }

}