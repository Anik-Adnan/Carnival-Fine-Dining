

class FoodCategoriesModel {
  final String foodCategoryId;
  final String foodCategoryImg;
  final String foodCategoryName;
  final dynamic createdAt;
  final dynamic updatedAt;

   FoodCategoriesModel({
    required this.foodCategoryId,
    required this.foodCategoryImg,
    required this.foodCategoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  // Serialize the CategoryModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'foodCategoryId': foodCategoryId,
      'foodCategoryImg': foodCategoryImg,
      'foodCategoryName': foodCategoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a UserModel instance from a JSON map
  factory FoodCategoriesModel.fromMap(Map<String, dynamic> json) {
    return FoodCategoriesModel(
      foodCategoryId: json['foodCategoryId'],
      foodCategoryImg: json['foodCategoryImg'],
      foodCategoryName: json['foodCategoryName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}