// ignore_for_file: file_names

class OrderModel {

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
  final String customerId;
  final bool status;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerDeviceToken;

  OrderModel({
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
    required this.customerId,
    required this.status,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerDeviceToken,
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
      'customerId': customerId,
      'status': status,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'customerDeviceToken': customerDeviceToken,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> json) {
    return OrderModel(
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
      customerId: json['customerId'],
      status: json['status'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerAddress: json['customerAddress'],
      customerDeviceToken: json['customerDeviceToken'],
    );
  }
}