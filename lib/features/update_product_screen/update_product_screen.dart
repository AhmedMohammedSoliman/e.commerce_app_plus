import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_tharwat_samy/features/update_product_screen/admin_product_widget.dart';
import 'package:e_commerce_tharwat_samy/features/update_product_screen/bottom_sheet_widget.dart';
import 'package:e_commerce_tharwat_samy/features/update_product_screen/update_product_screen_navigator.dart';
import 'package:e_commerce_tharwat_samy/features/update_product_screen/update_product_screen_view_model.dart';
import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:e_commerce_tharwat_samy/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UpdateProductScreen extends StatefulWidget {
  static const String routeName = "update" ;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> implements UpdateProductScreenNavigator{

  UpdateProductScreenViewModel viewModel = UpdateProductScreenViewModel();
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
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9,
                      crossAxisCount: 2
                  ),
                  itemCount: productsList!.length,
                  itemBuilder: (context , index) => InkWell(
                    onTap: (){
                      showBottomSheetFun(productsList[index]);
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
      ),    );
  }
  void showBottomSheetFun (ProductModel productModel){
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetWidget(productModel: productModel,));
  }

}