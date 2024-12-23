
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CalculateProductRatingCotroller extends GetxController{
  final String productId;

  RxDouble avgRating = 0.0.obs;

  CalculateProductRatingCotroller(this.productId);

  @override
  void onInit() {
    calculateAvgRating();
    super.onInit();
  }

  void calculateAvgRating() async{
    await FirebaseFirestore.instance.collection('foods')
        .doc(productId)
        .collection('reviews')
        .snapshots()
        .listen(
        (snapshot) async {
          if(snapshot.docs.isNotEmpty){
            double totalrating = 0.0;
            int numberOfReviews = 0;

            snapshot.docs.forEach(
                (doc){
                  // final rating = doc['rating'] as double;
                  final rating = double.tryParse(doc['rating']);

                  if(rating != null){
                     totalrating += rating;
                     numberOfReviews++;
                     print("Rating:  ${rating}");
                  }
                });
            if(numberOfReviews != 0){
              avgRating.value = totalrating / numberOfReviews;
              print("avgRating:  ${avgRating.value}");
              await FirebaseFirestore.instance.collection('foods')
                  .doc(productId)
                  .update({'avgRating': avgRating.value.toString()});


            }else{
              avgRating.value = 1.0;
            }

          }else{
            avgRating.value = 1.0;
          }
        });
  }

}