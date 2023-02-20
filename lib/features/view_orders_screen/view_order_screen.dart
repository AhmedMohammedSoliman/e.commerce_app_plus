import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fireBase/fireBase_fun.dart';
import '../../models/orders_model.dart';

class ViewOrdersScreen extends StatelessWidget{
  static const String routeName = "orders";
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       backgroundColor: Colors.blue,
      body: StreamBuilder<QuerySnapshot<OrdersModel>>(
        stream: FireBaseFuns.getOrdersFromFireBase(),
        builder: (context , asyncSnapShot){
          if (asyncSnapShot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else {
            if (asyncSnapShot.hasError){
              return Column(
                children: [
                  Text(asyncSnapShot.error.toString()),
                  ElevatedButton(onPressed:(){

                  }, child: Text("Try again"))
                ],
              );
            }else {
              /// data
              var ordersList = asyncSnapShot.data?.docs.map((order) => order.data()).toList();
              return ordersList!.length == 0 ? Center(child: Text("Orders List is empty" ,
              style: TextStyle(color: Colors.white, fontSize: 20),),) :
              ListView.builder(
                itemBuilder: (context , index) => Container(
                  child: Text("${ordersList[index].location}" , style: TextStyle(fontSize: 30),),
                ) ,
                itemCount: ordersList.length,);
            }
          }
        },
      ),
     ),
   );
  }
}