import 'package:e_commerce_tharwat_samy/features/add_produce_screen/add_produce_screen.dart';
import 'package:e_commerce_tharwat_samy/features/delete_product_screen/delete_product_screen.dart';
import 'package:e_commerce_tharwat_samy/features/show_product_screen/show_products_screen.dart';
import 'package:e_commerce_tharwat_samy/features/update_product_screen/update_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_orders_screen/view_order_screen.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = "admin" ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text ("Please choose what do you want to do" , style: TextStyle (color: Colors.white ,
              fontWeight: FontWeight.bold , fontSize: 18),),
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                    onPressed: (){
                   Navigator.pushNamed(context, AddProductScreen.routeName);
                    }, child: Text ("Add product") ,
                style: ElevatedButton.styleFrom(shape: StadiumBorder(
                ) , primary: Colors.orangeAccent),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, UpdateProductScreen.routeName);
                  }, child: Text ("Update product") ,
                  style: ElevatedButton.styleFrom(shape: StadiumBorder(
                  ) , primary: Colors.orangeAccent),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, DeleteProductScreen.routeName);
                  }, child: Text ("Delete product") ,
                  style: ElevatedButton.styleFrom(shape: StadiumBorder(
                  ) , primary: Colors.orangeAccent),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, ViewOrdersScreen.routeName);
                  }, child: Text ("View orders") ,
                  style: ElevatedButton.styleFrom(shape: StadiumBorder(
                  ) , primary: Colors.orangeAccent),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, ShowProductScreen.routeName);
                  }, child: Text ("View all products") ,
                  style: ElevatedButton.styleFrom(shape: StadiumBorder(
                  ) , primary: Colors.orangeAccent),),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

}
