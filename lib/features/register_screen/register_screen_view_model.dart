import 'package:e_commerce_tharwat_samy/features/register_screen/regiser_screen_navigator.dart';
import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:e_commerce_tharwat_samy/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator ;
  void signUpFun (String email , String password , String userName)async{
    try {
      navigator.showLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(id: credential.user?.uid ?? "",email: email, userName: userName);
      var userObject = FireBaseFuns.addUserToFireBase(userModel);
      navigator.hideLoading();
      navigator.navigateToMajor(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMessage("The password provided is too weak.");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();
        navigator.showMessage("The account already exists for that email.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}