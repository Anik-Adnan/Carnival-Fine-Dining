import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import '../models/food_model.dart';
import '../screens/user-panel/food_item_details_screen.dart';

class AllFoodItemsWidget extends StatelessWidget {
  const AllFoodItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('product')
          // .where('isSale', isEqualTo: false)
          .get(),
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
            child: Text("No Food Item found!"),
          );
        }

        if (snapshot.data != null) {
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final foodData = snapshot.data!.docs[index];
              FoodModel productModel = FoodModel(
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
                    onTap: () => {
                    Get.to(ProductDetailsScreen(foodModel: productModel,)),
                  },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: FillImageCard(
                          borderRadius: 20.0,
                          width: Get.width / 3.47,
                          heightImage: Get.height / 10,
                          imageProvider: CachedNetworkImageProvider(
                            productModel.foodImages[0],
                          ),
                          title: Center(
                            child: Text(
                              productModel.foodName,
                              style: TextStyle(fontSize: 14.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          footer: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${productModel.salePrice}Tk",
                                style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${productModel.fullPrice}Tk",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return Container();
      },
    );
  }
}