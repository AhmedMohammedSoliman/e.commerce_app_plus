import 'package:e_commerce_tharwat_samy/features/login_screen/login_screen_navigator.dart';
import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenViewModel extends ChangeNotifier{
 late LoginNavigator navigator ;

 void loginFun (String email , String password)async{
  try {
   navigator.showLoading();
   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   );
   var userObject = await FireBaseFuns.getUserFromFireBase(credential.user?.uid ?? "");
   navigator.hideLoading();
   navigator.navigateToMajor(userObject!);
  } on FirebaseAuthException catch (e) {
   navigator.showLoading();
   if (e.code == 'user-not-found') {
    navigator.hideLoading();
    navigator.showMessage("No user found for that email.");
    print('No user found for that email.');
   } else if (e.code == 'wrong-password') {
    navigator.hideLoading();
    navigator.showMessage("Wrong password provided for that user.");
    print('Wrong password provided for that user.');
   }
  }
 }

 void loginFunAdmin (String email , String password)async{
  try {
   navigator.showLoading();
   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   );
   navigator.hideLoading();
   if (password == "0123456789" && email == "admin1@gmail.com"){
    navigator.navigateToAdminScreen();
   }
  } on FirebaseAuthException catch (e) {
   if (e.code == 'user-not-found') {
    navigator.showMessage("No admin found for that email");
    print('No user found for that email.');
   } else if (e.code == 'wrong-password') {
    navigator.showMessage("Wrong password provided for that admin.");
    print('Wrong password provided for that user.');
   }
  }
 }
}