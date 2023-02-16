import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_tharwat_samy/features/admin_screen/admin_screen.dart';
import 'package:e_commerce_tharwat_samy/features/delete_product_screen/delete_product_screen.dart';
import 'package:e_commerce_tharwat_samy/features/update_product_screen/update_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../fireBase/fireBase_fun.dart';
import '../../models/product_model.dart';
import '../update_product_screen/admin_product_widget.dart';

class ShowProductScreen extends StatefulWidget {
  static const String routeName = "show" ;

  @override
  State<ShowProductScreen> createState() => _ShowProductScreenState();
}

class _ShowProductScreenState extends State<ShowProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        backgroundColor: Colors.blue,
        body: StreamBuilder<QuerySnapshot<ProductModel>>(
          stream: FireBaseFuns.getProductsFromFireBase(),
          builder: (context , asyncSnapShot){
            if (asyncSnapShot.connectionState == ConnectionState.waiting){
              return Center(
                child:
                CircularProgressIndicator(
                  color: Colors.orangeAccent,
                ),
              );
            }else if (asyncSnapShot.hasError){
              return Column(
                children: [
                  Icon(Icons.signal_wifi_connected_no_internet_4_outlined , size: 60,) ,
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){

                  }, child: Text("Try again" , style: TextStyle(color: Colors.white),) , style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),)
                ],
              );
            }else {
              /// data
              var productsList = asyncSnapShot.data?.docs.map((product) => product.data()).toList();
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                  itemCount: productsList!.length,
                  itemBuilder: (context , index) => GestureDetector(
                    onTapUp: (details){
                      double dx = details.globalPosition.dx ;
                      double dy = details.globalPosition.dy ;
                      double dx2 = MediaQuery.of(context).size.width - dx ;
                      double dy2 = MediaQuery.of(context).size.height - dy ;
                      showMenuFun(dx , dx2 , dy , dy2);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AdminProductWidget(
                          description: productsList[index].description,
                          image: productsList[index].image,
                          name: productsList[index].name,
                          price: productsList[index].price ,
                          category: productsList[index].category,
                        )
                    ),
                  ));
            }
          },
        ),
      );
  }

  void showMenuFun (double dx , double dx2 , double dy , double dy2){
    showMenu
      (context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          PopupMenuItem(child: InkWell(
            onTap: (){
              Navigator.pushNamed(context , DeleteProductScreen.routeName);
            },
              child: Text("Delete"))),
          PopupMenuItem(child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, UpdateProductScreen.routeName);
            },
              child: Text("Update"))),
          PopupMenuItem(child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, AdminScreen.routeName);
              },
              child: Text("Back to home"))),
        ]);
  }
}