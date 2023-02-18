import 'dart:io';
import 'package:e_commerce_tharwat_samy/features/card_screen/card_screen.dart';
import 'package:e_commerce_tharwat_samy/providers/card_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget{
  static const String routeName = "details";

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CardProvider>(context);
    var args = ModalRoute.of(context)?.settings.arguments as Map ;
    return Stack(
      children: [
        Image(image: FileImage(File ("${args["image"]}")) , fit: BoxFit.fill , width: double.infinity ,
        height: double.infinity,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar (
            iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.red[700]),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15) ,
              child: IconButton(onPressed:(){
                   Navigator.pushNamed(context, CardScreen.routeName);
                 }, icon: Icon(Icons.shopping_cart_outlined , color: Colors.red[700],),))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text ("${args["name"]}" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Text ("${args["price"]} EGP", style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orangeAccent,
                                child: IconButton(onPressed: (){
                                 incrementCount();
                                }, icon: Icon (Icons.add , color: Colors.white,)),
                              ),
                              SizedBox(width: 20,),
                              Text("${counter}", style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold)),
                              SizedBox(width: 20,),
                              CircleAvatar(
                                backgroundColor: Colors.orangeAccent,
                                child: IconButton(onPressed: (){
                                  decrementCount();
                                }, icon: Icon (Icons.remove , color: Colors.white,)),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(onPressed: (){
                      provider.showSnackFun(args["product"], context);
                      provider.addToCard(args["product"]);
                      provider.cardProducts[args["index"]].count = counter ;
                    }, child: Text("Add to card" .toUpperCase()) , style: ElevatedButton.styleFrom(
                      shape: StadiumBorder() , primary: Colors.orangeAccent
                    ),),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
  void incrementCount (){
    counter ++ ;
    setState((){});
  }
  void decrementCount (){
    if (counter >0){
      counter -- ;
      setState((){});
    }
  }

}