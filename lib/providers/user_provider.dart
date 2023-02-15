import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:e_commerce_tharwat_samy/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {

  User? fireBaseUser ;
  UserModel? user ;

  UserProvider (){
    fireBaseUser = FirebaseAuth.instance.currentUser ;
    initUser ();
  }

  void initUser()async {
    if (fireBaseUser != null){
      user = await FireBaseFuns.getUserFromFireBase(fireBaseUser?.uid ?? "");
    }
  }

}