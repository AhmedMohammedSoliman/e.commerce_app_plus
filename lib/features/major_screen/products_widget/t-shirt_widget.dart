import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../fireBase/fireBase_fun.dart';
import '../../../models/product_model.dart';
import '../../update_product_screen/admin_product_widget.dart';
import '../product_details/product_details_screen.dart';

class TShirtWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
            var products = productsList!.where((product) => product.category == "t-shirts").toList() ;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9,
                    crossAxisCount: 2
                ),
                itemCount: products.length,
                itemBuilder: (context , index) => GestureDetector(
                  onTapUp: (details){
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, ProductDetails.routeName,arguments:  {
                            "product" : products[index],
                            "name" : products[index].name ,
                            "image" : products[index].image ,
                            "price" : products[index].price ,
                            "count" : products[index].count,
                            "index" : index,
                          });
                        },
                        child: AdminProductWidget(
                          description: products[index].description,
                          image: products[index].image,
                          name: products[index].name,
                          price: products[index].price ,
                          category: products[index].category,
                        ),
                      )
                  ),
                ));
          }
        },
      ),
    );
  }
}