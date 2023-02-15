import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:flutter/material.dart';

import 'delete_screen_navigator.dart';

class DeleteScreenViewModel extends ChangeNotifier {
  late DeleteScreenNavigator navigator ;

  void deleteProduct (String productId) async{
    var product = await FireBaseFuns.deleteProductFromFireBase(productId);
  }
}