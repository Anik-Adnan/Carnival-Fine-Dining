
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user-model.dart';
import '../screens/user-panel/main-screen.dart';
import 'get-device-token-controller.dart';

class GoogleSignInController extends GetxController{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async{
    final GetDeviceTokenController getDeviceTokenController = Get.put(GetDeviceTokenController());
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();

      if(googleSignInAccount != null){
        EasyLoading.show(status: "Please wait...");
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication?.accessToken,
          idToken: googleSignInAuthentication?.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if(user != null){
          UserModel userModel = UserModel(
              uId: user.uid,
              userName: user.displayName.toString(),
              email: user.email.toString(),
              phone: user.phoneNumber.toString(),
              userImg: user.photoURL.toString(),
              userDeviceToken: getDeviceTokenController.deviceToken.toString(),
              userCity: '',
              country: '',
              userAddress: '',
              street: '', isAdmin: false,
              isActive: true,
              createdOn: DateTime.now());

          await FirebaseFirestore.instance.collection('users')
              .doc(user.uid)
              .set(userModel.toMap());

          EasyLoading.dismiss();
          Get.offAll(() => const MainScreen());
          var uName= user.displayName.toString();
          Get.snackbar("LogIn successfully ", "Dear $uName welcome to BiswasShoppingBD" );

        }
      }
    }catch(e){
      EasyLoading.dismiss();
      print("Error $e");
    }
  }
}