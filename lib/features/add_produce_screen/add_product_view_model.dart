import 'dart:io';
import 'package:e_commerce_tharwat_samy/features/add_produce_screen/add_produt_navigator.dart';
import 'package:e_commerce_tharwat_samy/features/show_product_screen/show_products_screen.dart';
import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:e_commerce_tharwat_samy/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductScreenViewModel extends ChangeNotifier {
  late AddProductScreenNavigator navigator ;

  void addProductFun (String name , String category , String image , String description , BuildContext context ,
      String price) async {
    ProductModel productModel = ProductModel(
        name: name,
        category: category,
        image: image,
        description: description,
        price: price,
        count: 0);
      await FireBaseFuns.addProductToFireBase(productModel).then((value) =>
       showDialog(
           context: context,
           builder: (context) => AlertDialog(
             content: Text("Done", style: TextStyle(fontSize: 18),),
             actions: [
               TextButton(onPressed: (){
                Navigator.pushNamed(context, ShowProductScreen.routeName);
                 },
                   child: Text ("Ok"))
                    ],
                  )));
    }

    Future <String> uploadImage (String image)async{
    final file = File(image);
    final firebaseStorageRef = FirebaseStorage.instance.ref().child("images/$image");
    final uploadImage = await firebaseStorageRef.putFile(file);
    var imageUrl = FirebaseStorage.instance.ref().child("images/$image").getDownloadURL();
    return imageUrl ;
    }
}