
import 'package:carnival_fine_dining_restaurant_project/screens/user-panel/main-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../models/order-model.dart';
import '../../models/food_review_model.dart';

class ReviewAndRatingDialog {
  static void showReviewDialog(BuildContext context, OrderModel orderModel) {
    final TextEditingController feedbackController = TextEditingController();
    final User? user = FirebaseAuth.instance.currentUser;

    double initialRating = 3.0;

    showDialog(
      context: context,
      barrierDismissible: true, // Allows dismissing by tapping outside
      builder: (context) {
        return StatefulBuilder(
          builder: (context,setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rate Your Experience & Review",
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '$initialRating',
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        initialRating = rating;
                        setState(() {
                          initialRating = rating; // Update the rating dynamically.
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Feedback",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: feedbackController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Share your Feedback",
                        // floatingLabelBehavior: FloatingLabelBehavior.always, // Label always stays above

                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          // style: ElevatedButton.styleFrom(
                          //   backgroundColor: Colors.grey[300],
                          // ),
                          onPressed: () {
                            Get.back(); // Close the dialog
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            EasyLoading.show(status: "Submitting review...");
                            String feedback = feedbackController.text.trim();

                            ReviewModel reviewModel = ReviewModel(
                              customerName: orderModel.customerName,
                              customerPhone: orderModel.customerPhone,
                              customerDeviceToken: orderModel.customerDeviceToken,
                              customerId: orderModel.customerId,
                              feedback: feedback,
                              rating: initialRating.toString(),
                              createdAt: DateTime.now(),
                            );

                            await FirebaseFirestore.instance
                                .collection('foods')
                                .doc(orderModel.foodId)
                                .collection('reviews')
                                .doc(user!.uid)
                                .set(reviewModel.toMap());

                            EasyLoading.dismiss();

                            Get.back(); // Close the dialog
                            Get.offAll(()=>MainScreen()); // Navigate to the home screen
                          },
                          child: Text("Submit", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
}