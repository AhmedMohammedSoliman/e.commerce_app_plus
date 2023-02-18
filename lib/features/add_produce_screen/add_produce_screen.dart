import 'dart:io';
import 'package:e_commerce_tharwat_samy/features/add_produce_screen/add_product_view_model.dart';
import 'package:e_commerce_tharwat_samy/features/add_produce_screen/add_produt_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../update_product_screen/update_product_screen.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "add";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> implements AddProductScreenNavigator{
  String name = "" ;

  String description = "" ;

  String category = "" ;

  String price = "" ;

  XFile? imageFile ;

  ImagePicker picker = ImagePicker();

  AddProductScreenViewModel viewModel = AddProductScreenViewModel();

  var formKey = GlobalKey<FormState>();

 @override
  void initState() {
    viewModel.navigator = this ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Center (
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                      onChanged: (text){
                     name = text ;
                },
                  validator: (text){
                    if (text == null || text.trim().isEmpty){
                      return "Please this is required" ;
                    }else {
                      return null ;
                    }
                  },
                  decoration: InputDecoration (
                      hintText: "Product name" ,
                      filled: true ,
                      fillColor: Colors.orangeAccent ,
                      enabledBorder: UnderlineInputBorder (
                          borderRadius: BorderRadius.circular(30) ,
                          borderSide: BorderSide (color: Colors.white , width: 2)
                      ),
                      focusedBorder: UnderlineInputBorder (
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide (color: Colors.white , width: 2)
                      )
                  ),
                ),
                      SizedBox(height: 10,),
                      TextFormField(
                        onChanged: (text){
                          price = text ;
                        },
                        validator: (text){
                          if (text == null || text.trim().isEmpty){
                            return "Please this is required" ;
                          }else {
                            return null ;
                          }
                        },
                        decoration: InputDecoration (
                            hintText: "Product price" ,
                            filled: true ,
                            fillColor: Colors.orangeAccent ,
                            enabledBorder: UnderlineInputBorder (
                                borderRadius: BorderRadius.circular(30) ,
                                borderSide: BorderSide (color: Colors.white , width: 2)
                            ),
                            focusedBorder: UnderlineInputBorder (
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide (color: Colors.white , width: 2)
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        onChanged: (text){
                          description = text ;
                        },
                        validator: (text){
                          if (text == null || text.trim().isEmpty){
                            return "Please this is required" ;
                          }else {
                            return null ;
                          }
                        },
                        decoration: InputDecoration (
                            hintText: "Product description" ,
                            filled: true ,
                            fillColor: Colors.orangeAccent ,
                            enabledBorder: UnderlineInputBorder (
                                borderRadius: BorderRadius.circular(30) ,
                                borderSide: BorderSide (color: Colors.white , width: 2)
                            ),
                            focusedBorder: UnderlineInputBorder (
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide (color: Colors.white , width: 2)
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        onChanged: (text){
                          category = text ;
                        },
                        validator: (text){
                          if (text == null || text.trim().isEmpty){
                            return "Please this is required" ;
                          }else {
                            return null ;
                          }
                        },
                        decoration: InputDecoration (
                            hintText: "Product category" ,
                            filled: true ,
                            fillColor: Colors.orangeAccent ,
                            enabledBorder: UnderlineInputBorder (
                                borderRadius: BorderRadius.circular(30) ,
                                borderSide: BorderSide (color: Colors.white , width: 2)
                            ),
                            focusedBorder: UnderlineInputBorder (
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide (color: Colors.white , width: 2)
                            )
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: ()async{
                          imageFile = await picker.pickImage(source: ImageSource.gallery );
                          setState((){});
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.height*0.3,
                          color: Colors.orangeAccent,
                          child:   imageFile == null ? Icon(Icons.image) :
                          Image.file(File(imageFile!.path),
                          fit: BoxFit.fill,)
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton(
                          onPressed: (){
                             if (imageFile != null){
                              addProduct();
                              uploadImageToFireBase();
                             }else {
                               ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text("Please put an image")));
                             }
                          }, child: Text ("Confirm and add product") ,
                          style: ElevatedButton.styleFrom(shape: StadiumBorder(
                          ) , primary: Colors.orangeAccent),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void addProduct (){
   if (formKey.currentState?.validate() == true){
     viewModel.addProductFun(name, category, imageFile!.path, description , context , price);
   }
  }
  void uploadImageToFireBase()async{
   viewModel.uploadImage(imageFile!.path);
  }
}