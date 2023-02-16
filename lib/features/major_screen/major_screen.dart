import 'package:e_commerce_tharwat_samy/features/major_screen/products_widget/jackets_widget.dart';
import 'package:e_commerce_tharwat_samy/features/major_screen/products_widget/shoes_widget.dart';
import 'package:e_commerce_tharwat_samy/features/major_screen/products_widget/t-shirt_widget.dart';
import 'package:e_commerce_tharwat_samy/features/major_screen/products_widget/trouser_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MajorScreen extends StatefulWidget{
  static const String routeName = "major" ;

  @override
  State<MajorScreen> createState() => _MajorScreenState();
}

class _MajorScreenState extends State<MajorScreen> {
  int selectedIndex = 0 ;
  Color selectedColor = Colors.white ;
  int selectedItem = 0 ;
  @override
  Widget build(BuildContext context) {
   return Stack(
     children: [
       DefaultTabController(
         length: 4,
           child: Scaffold(
             bottomNavigationBar: Theme(
               data: Theme.of(context).copyWith(canvasColor: Colors.red),
               child: BottomNavigationBar (
                 selectedItemColor: Colors.black,
                 unselectedItemColor: Colors.white,
                 currentIndex: selectedItem,
                 onTap: (index){
                   selectedItem = index ;
                   setState((){});
                 },
                 items: [
                   BottomNavigationBarItem(icon: Icon(Icons.home) , label: "home") ,
                   BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "settings") ,
                   BottomNavigationBarItem(icon: Icon(Icons.favorite) , label: "favourite") ,
                 ],
               ),
             ),
             appBar: AppBar(
               backgroundColor: Colors.orangeAccent,
               elevation: 0,
               bottom: TabBar(
                 onTap: (index){
                   selectedIndex = index ;
                   setState((){});
                 },
                 indicatorColor: Colors.blue,
                 tabs: [
                   Text("Jackets" , style: TextStyle(fontSize: 15 , color: selectedIndex == 0 ?
                   Colors.black : Colors.white),),
                   Text("Trouser", style: TextStyle(fontSize: 15 , color: selectedIndex == 1 ?
                   Colors.black : Colors.white),),
                   Text("T-shirts", style: TextStyle(fontSize: 15 , color: selectedIndex == 2 ?
                   Colors.black : Colors.white),),
                   Text("Shoes", style: TextStyle(fontSize: 15 , color: selectedIndex == 3 ?
                   Colors.black : Colors.white),),
                 ],
               ),
             ),
             body: TabBarView (
               children: [
                 JacketWidget() ,
                 TrouserWidget() ,
                 TShirtWidget(),
                 ShoesWidget(),
               ],
             ),
           )) ,
       SafeArea(
         child: Material(
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 20),
             color: Colors.orangeAccent ,
             height: MediaQuery.of(context).size.height*0.1,
             child: Row (
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text("Discovery".toUpperCase() , style: TextStyle(color: Colors.red[700] , fontWeight: FontWeight.bold ,
                 fontSize: 18),),
                 IconButton(onPressed: (){

                 }, icon: Icon(Icons.shopping_cart_outlined , size: 25, color: Colors.red[700],))
               ],
             ),
           ),
         ),
       )
     ],
   );
  }

}