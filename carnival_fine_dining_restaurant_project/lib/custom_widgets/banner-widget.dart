
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnival_fine_dining_restaurant_project/models/food_model.dart';
import 'package:carnival_fine_dining_restaurant_project/screens/user-panel/food_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/banner-controller.dart';

class BannerWidget extends StatefulWidget{
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}
class _BannerWidgetState extends State<BannerWidget>{
  final CarouselController carouselController = CarouselController();
  final BannerController _bannerController = Get.put(BannerController());




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx((){
        if (_bannerController.banners.isEmpty) {
          return Center(child: Text('No banners available'));
        }
        return CarouselSlider(
          items: _bannerController.banners.map((foodModel)=>
              GestureDetector(
                onTap: ()=> Get.to(FoodDetailsScreen(foodModel: foodModel)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: foodModel.bannerImg.toString(),
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
                          ),
              ),).toList(),
            options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.5,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
              height: 200,
          ),
        );
      }),
    );
  }

}