


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import '../models/food_model.dart';
import '../screens/user-panel/food_details_screen.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('foods').where('isSale', isEqualTo: true).get(),
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
            child: Text("Today Has No Hot Deal"),
          );
        }

        if (snapshot.data != null) {
          return Container(
            height: Get.height / 5.0,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final foodData = snapshot.data!.docs[index];
                FoodModel foodModel = FoodModel(
                  foodId: foodData['foodId'],
                  foodCategoryId: foodData['foodCategoryId'],
                  foodName: foodData['foodName'],
                  foodCategoryName: foodData['foodCategoryName'],
                  salePrice: foodData['salePrice'],
                  fullPrice: foodData['fullPrice'],
                  foodImages: foodData['foodImages'],
                  deliveryTime: foodData['deliveryTime'],
                  isSale: foodData['isSale'],
                  foodDescription: foodData['foodDescription'],
                  createdAt: foodData['createdAt'],
                  updatedAt: foodData['updatedAt'],
                );
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(FoodDetailsScreen(foodModel: foodModel,)),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 4.0,
                            heightImage: Get.height / 12,
                            imageProvider: CachedNetworkImageProvider(
                              foodModel.foodImages[0],
                            ),
                            title: Center(
                              child: Text(
                                foodModel.foodName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                            footer: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${foodModel.salePrice}Tk",
                                  style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${foodModel.fullPrice}Tk",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}