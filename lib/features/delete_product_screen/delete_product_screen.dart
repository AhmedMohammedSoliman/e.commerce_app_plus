import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_tharwat_samy/features/delete_product_screen/delete_screen_navigator.dart';
import 'package:e_commerce_tharwat_samy/features/delete_product_screen/delete_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../fireBase/fireBase_fun.dart';
import '../../models/product_model.dart';
import '../update_product_screen/admin_product_widget.dart';

class DeleteProductScreen extends StatefulWidget {
  static const String routeName = "delete" ;

  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> implements DeleteScreenNavigator{
  DeleteScreenViewModel viewModel = DeleteScreenViewModel();
  @override
  void initState() {
    viewModel.navigator = this ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold (
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
              return ListView.builder(
                  itemCount: productsList!.length,
                  itemBuilder: (context , index) => InkWell(
                    onTap: (){
                      delete (productsList[index].id);
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
      ),
    );
  }

  void delete(String productId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
        content: Text("Are you sure you want delete ?"),
          actions: [
            TextButton(
                onPressed: (){
                  viewModel.deleteProduct(productId);
                  Navigator.pop(context);
                },
                child: Text("Ok")) ,
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Cancel")) ,
          ],
    ));
  }
}