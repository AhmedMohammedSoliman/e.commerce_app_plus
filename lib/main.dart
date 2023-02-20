import 'package:e_commerce_tharwat_samy/features/add_produce_screen/add_produce_screen.dart';
import 'package:e_commerce_tharwat_samy/features/admin_screen/admin_screen.dart';
import 'package:e_commerce_tharwat_samy/features/login_screen/login_screen.dart';
import 'package:e_commerce_tharwat_samy/features/major_screen/product_details/product_details_screen.dart';
import 'package:e_commerce_tharwat_samy/features/register_screen/register_screen.dart';
import 'package:e_commerce_tharwat_samy/features/update_product_screen/update_product_screen.dart';
import 'package:e_commerce_tharwat_samy/features/view_orders_screen/view_order_screen.dart';
import 'package:e_commerce_tharwat_samy/providers/card_provider.dart';
import 'package:e_commerce_tharwat_samy/providers/user_provider.dart';
import 'package:e_commerce_tharwat_samy/theming/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'features/card_screen/card_screen.dart';
import 'features/delete_product_screen/delete_product_screen.dart';
import 'features/major_screen/major_screen.dart';
import 'features/show_product_screen/show_products_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
      child: ChangeNotifierProvider(
        create: (context) => CardProvider(),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: initialRouteFun(context),
      routes: {
        LoginScreen.routeName : (context) => LoginScreen() ,
        RegisterScreen.routeName : (context) => RegisterScreen(),
        MajorScreen.routeName : (context) => MajorScreen(),
        AdminScreen.routeName : (context) => AdminScreen(),
       AddProductScreen.routeName : (context) => AddProductScreen(),
        UpdateProductScreen.routeName : (context) => UpdateProductScreen(),
        DeleteProductScreen.routeName : (context) => DeleteProductScreen(),
        ShowProductScreen.routeName : (context) => ShowProductScreen(),
        ProductDetails.routeName : (context) => ProductDetails(),
        CardScreen.routeName : (context) => CardScreen(),
        ViewOrdersScreen.routeName : (context) => ViewOrdersScreen(),
      },
      locale: Locale ("en"),
      theme: ThemingData.lightTheme,
    );
  }
  String initialRouteFun (BuildContext context){
    var provider = Provider.of<UserProvider>(context , listen:  false);
    if (provider.fireBaseUser?.email == "admin1@gmail.com"){
      return AdminScreen.routeName ;
    }if (provider.fireBaseUser == null){
      return LoginScreen.routeName;
    }else {
      return MajorScreen.routeName ;
    }
  }
}


