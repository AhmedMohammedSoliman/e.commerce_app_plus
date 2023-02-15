import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminProductWidget extends StatelessWidget {
  String image ;
  String name ;
  String description ;
  String price ;
  String category ;
  AdminProductWidget ({required this.name , required this.image , required this.description,
  required this.category
  , required this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              height: MediaQuery.of(context).size.height*0.3,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image(image: AssetImage(image), fit: BoxFit.fill,),
            ),
          ) ,
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text("category : ${category}" , style: TextStyle(color: Colors.white ,
                        fontSize: 18),)),
                  ],
                ) ,
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child: Text("name : ${name}" , style: TextStyle(color: Colors.white , fontSize: 18),)),
                  ],
                ) ,
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child: Text("description : ${description}" , style: TextStyle(color: Colors.white ,
                    fontSize: 18),)),
                  ],
                ) ,
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child: Text("price : ${price} EGP" , style: TextStyle(color: Colors.white ,
                        fontSize: 18),)),
                  ],
                ) ,
              ],
            ),
          )

        ],
      ),
    );
  }
}