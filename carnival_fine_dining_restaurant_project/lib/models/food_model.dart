
class FoodModel{
  final String foodId;
  final String foodCategoryId;
  final String foodName;
  final String foodCategoryName;
  final String salePrice;
  final String fullPrice;
  final List foodImages;
  final String deliveryTime;
  final bool isSale;
  final bool isBanner;
  final String bannerImg;
  final String foodDescription;
  final String orderCount;
  final String avgRating;
  final dynamic createdAt;
  final dynamic updatedAt;

  FoodModel({
    required this.foodId,
    required this.foodCategoryId,
    required this.foodName,
    required this.foodCategoryName,
    required this.salePrice,
    required this.fullPrice,
    required this.foodImages,
    required this.deliveryTime,
    required this.isSale,
    required this.isBanner,
    required this.bannerImg,
    required this.foodDescription,
    required this.orderCount,
    required this.avgRating,
    required this.createdAt,
    required this.updatedAt,
  });
  Map<String,dynamic> toMap(){
    return {
      'foodId': foodId,
      'foodCategoryId': foodCategoryId,
      'foodName': foodName,
      'foodCategoryName': foodCategoryName,
      'salePrice': salePrice,
      'fullPrice': fullPrice,
      'foodImages': foodImages,
      'deliveryTime': deliveryTime,
      'isSale': isSale,
      'isBanner': isBanner,
      'bannerImg' : bannerImg,
      'foodDescription': foodDescription,
      'orderCount': orderCount,
      'avgRating': avgRating,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FoodModel.fromMap(Map<String,dynamic> json){
    return FoodModel(
        foodId: json['foodId'],
        foodCategoryId: json['foodCategoryId'],
        foodName: json['foodName'],
        foodCategoryName: json['foodCategoryName'],
        salePrice: json['salePrice'],
        fullPrice: json['fullPrice'],
        foodImages: json['foodImages'],
        deliveryTime: json['deliveryTime'],
        isSale: json['isSale'],
      foodDescription: json['foodDescription'],
      orderCount: json['orderCount'],
      avgRating: json['avgRating'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      isBanner: json['isBanner'],
      bannerImg: json['bannerImg'],
    );
  }
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodId: json['foodId'],
      foodCategoryId: json['foodCategoryId'],
      foodName: json['foodName'],
      foodCategoryName: json['foodCategoryName'],
      salePrice: json['salePrice'],
      fullPrice: json['fullPrice'],
      foodImages: json['foodImages'],
      deliveryTime: json['deliveryTime'],
      isSale: json['isSale'],
      foodDescription: json['foodDescription'],
      orderCount: json['orderCount'],
      avgRating: json['avgRating'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isBanner: json['isBanner'],
      bannerImg: json['bannerImg'],
    );

  }

  @override
  String toString() {
    return 'FoodModel(foodId: $foodId,'
        ' foodCategoryId: $foodCategoryId,'
        ' foodName: $foodName,'
        ' foodCategoryName: $foodCategoryName,'
        ' salePrice: $salePrice,'
        ' fullPrice: $fullPrice,'
        ' foodImages: $foodImages,'
        ' deliveryTime: $deliveryTime,'
        ' isSale: $isSale,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt,'
        ' isBanner: $isBanner,'
        ' bannerImg: $bannerImg,'
        ' foodDescription: $foodDescription)';

  }
}