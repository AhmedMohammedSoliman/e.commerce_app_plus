import 'package:e_commerce_tharwat_samy/features/major_screen/product_details/product_details_screen.dart';
import 'package:e_commerce_tharwat_samy/fireBase/fireBase_fun.dart';
import 'package:e_commerce_tharwat_samy/models/orders_model.dart';
import 'package:e_commerce_tharwat_samy/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/card_provider.dart';
import '../update_product_screen/admin_product_widget.dart';

class CardScreen extends StatelessWidget {
  static const String routeName = "card" ;
  late CardProvider provider ;
  String location = "" ;
  @override
  Widget build(BuildContext context) {
  provider = Provider.of<CardProvider>(context);
    return  Scaffold(
      appBar: AppBar (
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.red[700]),
        title: Text("Your card" , style: TextStyle(color: Colors.red[700]),),
        centerTitle: true,
      ),
      body: Column (
        children: [
         provider.cardProducts.length == 0 ? Expanded(child: Center(child: Text ("Card is empty"),)) :
         Expanded(
           child: ListView.separated(
               separatorBuilder: (context , index) => SizedBox(height: 20,),
               itemCount: provider.cardProducts.length,
               itemBuilder: (context , index) => GestureDetector(
                   onTapUp: (details){
                     double dx = details.globalPosition.dx ;
                     double dy = details.globalPosition.dy ;
                     double dx2 = MediaQuery.of(context).size.width - dx ;
                     double dy2 = MediaQuery.of(context).size.height - dy ;
                     showMenuFun(context, dx, dy, dx2, dy2, provider.cardProducts[index]);
                   },
                   child: Row (
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: AdminProductWidget(
                               description: provider.cardProducts[index].description,
                               image: provider.cardProducts[index].image,
                               name: provider.cardProducts[index].name,
                               price: provider.cardProducts[index].price ,
                               category: provider.cardProducts[index].category,
                             )
                         ),
                       ),
                       Expanded(child: Container(
                           padding: EdgeInsets.all(10),
                           child: Text("Count : ${provider.cardProducts[index].count}", style: TextStyle(color: Colors.white ,
                               fontWeight: FontWeight.bold , fontSize: 20)
                               , textAlign: TextAlign.center)))
                     ],
                   )
               )),
         ) ,
         Container(
            width: MediaQuery.of(context).size.width*0.8,
            margin: EdgeInsets.all(10),
            child: ElevatedButton(onPressed:(){
              OrdersModel ordersModel = OrdersModel(products: provider.cardProducts,
                  totalPrice: totalPrice(provider.cardProducts), location: location);
                  orderNow(context, provider.cardProducts , ordersModel, location);
            }, child: Text ("Order NOW" .toUpperCase()), style: ElevatedButton.styleFrom(
              primary: Colors.red[700] , shape: StadiumBorder()
            ),),
          )
        ],
      ),

    );
  }
  void showMenuFun (BuildContext context , double dx , double dy , double dx2 , double dy2 , ProductModel productModel ,){
    showMenu(context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          PopupMenuItem(
            child: GestureDetector(
                onTap: (){
                  provider.removeFromCard(productModel);
                  Navigator.popUntil(context, (route) => route.settings.name == ProductDetails.routeName);
                },
                child: Text ("Edit")
            ) ,
          ),
          PopupMenuItem(
            child: GestureDetector(
            onTap: (){
              provider.removeFromCard(productModel);
              Navigator.pop(context);
            },
              child: Text ("Delete from card")
          ) ,
          ),
        ]);
    }
}
 void orderNow (BuildContext context , List<ProductModel> products , OrdersModel ordersModel , String location){

  showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      height: MediaQuery.of(context).size.height*0.1,
      child: Column (
        children: [
          Text("Total price : ${totalPrice(products)} EGP"),
          TextFormField(
            validator: (text){
              if (text == null || text.trim().isEmpty){
                return "Please enter location" ;
              }else {
                return null ;
              }
            },
            decoration: InputDecoration (
                 hintText: "Enter your location"
            ),
            onChanged: (text){
              location = text ;
            },
          )
        ],
      ),
    ),
    actions: [
      TextButton(
          onPressed: ()async{
            try {
            await FireBaseFuns.addOrdersToFireBase(ordersModel).then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Order added Successfully")
                      )
                  )
              );
            }catch (e){
              print (e);
            }
        Navigator.pop(context);

      }, child: Text("Confirm"))
    ],
  ));
 }
 int totalPrice (List<ProductModel> products){
  var totalPr = 0 ;
  for (var product in products){
    totalPr += (int.parse(product.price )* product.count) ;
  }
  return totalPr;
 }