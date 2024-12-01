
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/food_category_model.dart';
import 'all_single_foodItem_screen.dart';

class AllFoodCategoryScreen extends StatefulWidget{
  const AllFoodCategoryScreen({super.key});
  @override
  State<AllFoodCategoryScreen> createState() => _AllFoodCategoryScreenState();
  
}
class _AllFoodCategoryScreenState extends State<AllFoodCategoryScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Food Categories'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('foodCategories').get(),
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
              child: Text("No Food Category found!"),
            );
          }

          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.90,
                ),
                itemBuilder: (context, index) {
                var categoryData = snapshot.data!.docs[index];
                  FoodCategoriesModel foodCategoriesModel = FoodCategoriesModel(
                    foodCategoryId: categoryData['foodCategoryId'],
                    foodCategoryImg: categoryData['foodCategoryImg'],
                    foodCategoryName: categoryData['foodCategoryName'],
                    createdAt: categoryData['createdAt'],
                    updatedAt: categoryData['updatedAt'],
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(AllSingleFoodItemScreen(foodCategoryId: foodCategoriesModel.foodCategoryId)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width / 2.2,
                              heightImage: Get.height / 6,
                              imageProvider: CachedNetworkImageProvider(
                                foodCategoriesModel.foodCategoryImg,
                              ),
                              title: Center(
                                child: Text(
                                  foodCategoriesModel.foodCategoryName,
                                  style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
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