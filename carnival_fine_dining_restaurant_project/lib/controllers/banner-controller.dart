
import 'package:carnival_fine_dining_restaurant_project/models/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<FoodModel> banners = <FoodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('foods')
          .where('isBanner', isEqualTo: true)
          .get();

      // Map the snapshot data to a list of FoodModel objects
      List<FoodModel> bannerList = snapshot.docs.map((doc) {
        return FoodModel.fromJson(doc.data());
      }).toList();


      // Update the controller with the fetched banners
      banners.assignAll(bannerList);

      print("Banner list = "+banners.toString());

    } catch (e) {
      debugPrint("Error fetching banners: $e");
    }
  }
}
