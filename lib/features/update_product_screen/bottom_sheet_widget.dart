import 'dart:io';

import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/product_model.dart';

class BottomSheetWidget extends StatefulWidget {
  ProductModel productModel ;

  BottomSheetWidget ({required this.productModel}) ;
  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  String name2 = "" ;

  String description2 = "";

  String price2 = "" ;

  String category2 = "" ;

  XFile? imageFile ;

  ImagePicker imagePicker = ImagePicker();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column (
              children: [
                Text("Update Product" , style: TextStyle (color: Colors.black , fontSize: 20 ,
                fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text){
                    name2 = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty){
                      return "Please this in required" ;
                    }else {}
                    return null ;
                  },
                  decoration: InputDecoration (
                    hintText: "Product name"
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text){
                    description2 = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty){
                      return "Please this in required" ;
                    }else {}
                    return null ;
                  },
                  decoration: InputDecoration (
                      hintText: "Product description"
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text){
                    price2 = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty){
                      return "Please this in required" ;
                    }else {}
                    return null ;
                  },
                  decoration: InputDecoration (
                      hintText: "Product price"
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (text){
                    category2 = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty){
                      return "Please this in required" ;
                    }else {}
                    return null ;
                  },
                  decoration: InputDecoration (
                      hintText: "Product category"
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: ()async{
                    imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
                    setState((){});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: MediaQuery.of(context).size.height*0.2,
                    color: Colors.orangeAccent,
                    child: imageFile != null ?  Image.file(File(imageFile!.path) , fit: BoxFit.fill,) :
                    Icon (Icons.image),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: (){
                     if (imageFile != null){
                       update() ;
                     }
                    },
                    child: Text("Confirm and update") , style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent , shape: StadiumBorder()
                ),),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void update()async{
    if (formKey.currentState?.validate() == true){
      var product = await FireBaseFuns.updateProduct(name2,
          description2, price2,
          category2 , widget.productModel.id ,
           imageFile!.path) .
    then((value) => Navigator.pop(context));
    }
  }
}