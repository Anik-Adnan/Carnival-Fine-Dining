
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
  final String foodDescription;
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
    required this.foodDescription,
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
      'foodDescription': foodDescription,
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
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
    );
  }
}