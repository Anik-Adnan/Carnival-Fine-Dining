
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/rating_controller.dart';
import '../../models/cart-model.dart';
import '../../models/food_model.dart';
import '../../models/food_review_model.dart';
import '../../utils/app_constant.dart';
import 'cart_screen.dart';

class FoodDetailsScreen extends StatefulWidget{
  FoodModel foodModel;
  FoodDetailsScreen({super.key,required this.foodModel });

  @override
  State<StatefulWidget> createState() => _FoodDetailsScreenState();
  
}
class _FoodDetailsScreenState extends State<FoodDetailsScreen>{
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CalculateProductRatingCotroller calculateProductRatingCotroller = Get.put(CalculateProductRatingCotroller(widget.foodModel.foodId));

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.foodModel.foodName}'),
        actions:  [
          GestureDetector(
            onTap: ()=> Get.to(CartScreen()),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart,color: Colors.black,)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height/80.0),
              CarouselSlider(
                items: widget.foodModel.foodImages.map((imgUrls)=>
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imgUrls,
                        fit: BoxFit.cover,
                        width: Get.width-10.0,
                        placeholder: (context,url)=>
                            ColoredBox(
                              color: Colors.white,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),),
                        errorWidget: (context,url,error) => Icon(Icons.error),
                      ),
                    ),).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.5,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                  height: 200,
                ),
              ),
        
              Padding(
                padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: [
                      // abg rating
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                                  ()=> Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: RatingBar.builder(
                                      initialRating: double.parse(
                                        calculateProductRatingCotroller.avgRating.value.toString(),
                                      ),
                                      ignoreGestures: true,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (value) {
                                      },
                                                                      ),
                                  ),
                            ),
                            Text(widget.foodModel.avgRating,style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("CategoryID: ${widget.foodModel.foodCategoryId}"),
                            ),
                          ),
                          Icon(Icons.favorite_outline),
                          
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                            child: Text("ProductID: ${widget.foodModel.foodId}"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text("ProductName: ${widget.foodModel.foodName}"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text("Category: ${widget.foodModel.foodCategoryName}"),
                        ),
                      ),
        
        
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              widget.foodModel.isSale == true && widget.foodModel.salePrice != ''
                              ? Text("Price: "+ widget.foodModel.salePrice+"Tk",style: TextStyle(fontWeight: FontWeight.bold),)
                              : Text("Price: ${widget.foodModel.fullPrice} Tk",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Product Description: ${widget.foodModel.foodDescription}",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      child: Container(
                        width: Get.width * 0.35,
                        height: Get.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: AppConstant.WhatsAppColor,
                        ),
                        child: TextButton(
                          child: const Text("Whats App",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          onPressed: () {

                            sendMessageOnWhatsApp(productModel: widget.foodModel);
                          },
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        width: Get.width * 0.35,
                        height: Get.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: AppConstant.appSecondaryColor,
                        ),
                        child: TextButton(
                          child: const Text("Add to cart",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          onPressed: () async {

                            await checkProductExistence(uId: user!.uid);
                            Get.snackbar(
                              "Product added to the cart",
                              "Please! confrim the order.",
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.white,
                              duration: Duration(seconds: 1),
                            );
                            //
                            // // get server key
                            // GetServerKey getServerKey = GetServerKey();
                            // String accesstoken = await getServerKey.getServerKeyToken();
                            // print("Server Access token: ${accesstoken}");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // reviews
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('foods').doc(widget.foodModel.foodId
                ).collection('reviews').get(),
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
                      child: Text("No Reviews found!"),
                    );
                  }

                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),

                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];

                        ReviewModel reviewModel = ReviewModel(
                            customerName: data['customerName'],
                            customerPhone: data['customerPhone'],
                            customerDeviceToken: data['customerDeviceToken'],
                            customerId: data['customerId'],
                            feedback: data['feedback'],
                            rating: data['rating'],
                            createdAt: data['createdAt'],
                        );
                        
                        return Card(
                          elevation: 1,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(reviewModel.customerName[0].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0),),
                            ),
                            title: Text(reviewModel.customerName,style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(reviewModel.feedback,style: TextStyle(),)
                            ),
                            trailing: Text(textAlign: TextAlign.justify,
                              '${reviewModel.rating} ⭐',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,),),
                          ),
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),




            ],
          ),
        
        
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsApp({required FoodModel productModel}) async{

    final contactNumber = AppConstant.WhatAppNumber;
    final message = "Hello ${AppConstant.appName}!\nI want to know about this product\nCategoryName: ${productModel.foodCategoryName}\nProduct Name: ${productModel.foodName}";
    final url = 'https://wa.me/$contactNumber?text=${Uri.encodeComponent(message)}';

    try {
      Uri requestedUri = Uri.parse(url);// .parse is the correct method

      if (await canLaunchUrl(requestedUri)) {
        await launchUrl(requestedUri);
      } else {
        throw  Exception('Could not launch $url');
      }
    } on PlatformException catch (e) {
      debugPrint("PlatformException launchInBrowser : $e");
    } on Exception catch (e) {
      debugPrint( "Exception launchInBrowser : $e");
    }

    //add androidmenifest.xml
    /*
    <!-- for Url Luncher -->
    <queries>
    <intent>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" />
    </intent>
    </queries>
     */

  }


  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.foodModel.foodId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int foodItemsQuantity = snapshot['foodItemsQuantity'];
      int updatedQuantity = foodItemsQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.foodModel.isSale
          ? widget.foodModel.salePrice
          : widget.foodModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'foodItemsQuantity': updatedQuantity,
        'foodItemsTotalPrice': totalPrice
      });

      print("product exists");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set(
        {
          'uId': uId,
          'createdAt': DateTime.now(),
        },
      );

      CartModel cartModel = CartModel(
        foodId: widget.foodModel.foodId,
        foodCategoryId: widget.foodModel.foodCategoryId,
        foodName: widget.foodModel.foodName,
        foodCategoryName: widget.foodModel.foodCategoryName,
        salePrice: widget.foodModel.salePrice,
        fullPrice: widget.foodModel.fullPrice,
        foodImages: widget.foodModel.foodImages,
        deliveryTime: widget.foodModel.deliveryTime,
        isSale: widget.foodModel.isSale,
        foodDescription: widget.foodModel.foodDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        foodItemsQuantity: 1,
        foodItemsTotalPrice: double.parse(widget.foodModel.isSale
            ? widget.foodModel.salePrice
            : widget.foodModel.fullPrice),
      );

      await documentReference.set(cartModel.toMap());

      print("Food added");
    }
  }
  
}