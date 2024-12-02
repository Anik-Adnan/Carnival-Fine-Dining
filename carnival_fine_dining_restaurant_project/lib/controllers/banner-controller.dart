
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{
  RxList<String> bannersUrls = RxList<String>([]);
  RxList<Map<String, String>> banners = RxList<Map<String, String>>([]);


  @override
  void onInit(){
    super.onInit();
    fetchBannersUrls();
  }

  Future<void> fetchBannersUrls()async{
    try{
      QuerySnapshot bannersSnapshot = await FirebaseFirestore.instance.collection('banners').get();
      // QuerySnapshot bannersSnapshotForFoodItems = await FirebaseFirestore.instance.collection('foods').where('isSale', isEqualTo: true).get();

      // from banner collection
      if(bannersSnapshot.docs.isNotEmpty){
        bannersUrls.value = bannersSnapshot.docs
            .map((doc) => doc['imgUrl'] as String).toList();
      }

      else {
        print('No banners found.');
      }
    } catch(e){
      print("$e");
    }
  }
}