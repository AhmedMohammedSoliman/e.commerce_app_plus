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
  , required this.price });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
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
            child: Image(image: NetworkImage(image), fit: BoxFit.fill, width: double.infinity,
            height: double.infinity,),
          ) ,
          SizedBox(width: 8,),
          Opacity(
            opacity: 0.5,
            child: Container(
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(20) ,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
               height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("${name}" , style: TextStyle(color: Colors.black , fontSize: 18 ),) ,
                   Text("${price} EGP" , style: TextStyle(color: Colors.black ,
                  fontSize: 18)),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}