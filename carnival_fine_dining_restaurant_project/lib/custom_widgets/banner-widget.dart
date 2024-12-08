
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carnival_fine_dining_restaurant_project/models/food_model.dart';
import 'package:carnival_fine_dining_restaurant_project/screens/user-panel/food_details_screen.dart';
import 'package:carnival_fine_dining_restaurant_project/utils/app_constant.dart';
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
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx((){
        if (_bannerController.banners.isEmpty) {
          return Center(child: Text('No banners imgs available'));
        }
        return Column(
          children: [
            CarouselSlider(
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
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
              ),
            ),
            // Dotted Indicator
            SizedBox(height: 8.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _bannerController.banners.length,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  height: 8.0,
                  width: _currentIndex == index ? 16.0 : 8.0,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppConstant.appSecondaryColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

}