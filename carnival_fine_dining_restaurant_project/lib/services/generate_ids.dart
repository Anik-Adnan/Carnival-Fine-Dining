// ignore_for_file: file_names

import 'package:uuid/uuid.dart';

class GenerateIds {
  String generateProductId() {
    String formatedProductId;
    String uuid = const Uuid().v4();

    //customize id
    formatedProductId = "carnival-fine-dining-${uuid.substring(0, 5)}";

    //return
    return formatedProductId;
  }

  String generateCategoryId() {
    String formatedCategoryId;
    String uuid = const Uuid().v4();

    //customize id
    formatedCategoryId = "carnival-fine-dining-${uuid.substring(0, 5)}";

    //return
    return formatedCategoryId;
  }
}