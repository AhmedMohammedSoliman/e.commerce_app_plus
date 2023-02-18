import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CardProvider extends ChangeNotifier {
  List <ProductModel> cardProducts = [] ;

  void addToCard (ProductModel productModel){
    bool isExist = cardProducts.contains(productModel);
    if (isExist){
      return ;
    }else {
      cardProducts.add(productModel);
    }
    notifyListeners();
  }
  void removeFromCard (ProductModel productModel){
    cardProducts.remove(productModel);
    notifyListeners();
  }

  void showSnackFun (ProductModel productModel , BuildContext context){
    bool isExist = cardProducts.contains(productModel);
    if (isExist){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Product is exist in card")));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Product is added to card")));
    }
  }

}