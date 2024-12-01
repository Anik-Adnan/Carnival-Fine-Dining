// ignore_for_file: file_names

class CartModel {
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
  final int foodItemsQuantity;
  final double foodItemsTotalPrice;

  CartModel({
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
    required this.foodItemsQuantity,
    required this.foodItemsTotalPrice,
  });

  Map<String, dynamic> toMap() {
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
      'foodItemsQuantity': foodItemsQuantity,
      'foodItemsTotalPrice': foodItemsTotalPrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
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
      foodItemsQuantity: json['foodItemsQuantity'],
      foodItemsTotalPrice: json['foodItemsTotalPrice'],
    );
  }
}