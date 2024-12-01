
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import '../../models/food_model.dart';
import 'food_item_details_screen.dart';

class AllSingleFoodItemScreen extends StatefulWidget{
  String foodCategoryId;
  AllSingleFoodItemScreen({super.key,required this.foodCategoryId});

  @override
  State<AllSingleFoodItemScreen> createState() => _AllSingleFoodItemScreenState();
}
class _AllSingleFoodItemScreenState extends State<AllSingleFoodItemScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodCategoryId),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('foods').where('foodCategoryId', isEqualTo: widget.foodCategoryId).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: const Text("Error"),
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
              child:const  Text("No Food Found!"),
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
                childAspectRatio: 0.75,
              ),
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
                      onTap: () {
                        Get.to(ProductDetailsScreen(foodModel: foodModel,));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 3.5,
                            heightImage: Get.height / 8,
                            imageProvider: CachedNetworkImageProvider(
                              foodModel.foodImages[0],
                            ),
                            title: Center(
                              child: Text(
                                foodModel.foodName,
                                style: TextStyle(fontSize: 12.0),
                                overflow: TextOverflow.ellipsis,
                              ),
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
      ),

    );
  }

}