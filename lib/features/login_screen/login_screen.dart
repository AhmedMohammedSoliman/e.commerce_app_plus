import 'package:e_commerce_tharwat_samy/features/admin_screen/admin_screen.dart';
import 'package:e_commerce_tharwat_samy/features/login_screen/login_screen_view_model.dart';
import 'package:e_commerce_tharwat_samy/features/major_screen/major_screen.dart';
import 'package:e_commerce_tharwat_samy/models/user_model.dart';
import 'package:e_commerce_tharwat_samy/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register_screen/register_screen.dart';
import 'login_screen_navigator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "home";


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator{
  LoginScreenViewModel viewModel = LoginScreenViewModel() ;
  var formKey = GlobalKey<FormState>();
  String email = "" ;
  String password = "";
  bool isChecked1 = false ;
  bool isChecked2 = false ;
  @override
  void initState() {
    viewModel.navigator = this ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewModel,
      child: SafeArea(
        child: Scaffold(
         backgroundColor: Colors.orangeAccent,
         body: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Center(
               child: SingleChildScrollView(
                 child: Form(
                   key: formKey,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image(image: AssetImage ("assets/images/order.png") , width: 100, height: 100,) ,
                       SizedBox(height: 10,),
                       Text ("Buy it" , style: TextStyle(fontFamily: "Schyler" , fontSize: 25 , fontWeight:
                       FontWeight.bold),) ,
                       SizedBox(height: 40,),
                       TextFormField(
                         onChanged: (text){
                           email = text ;
                         },
                         validator: (text){
                           if (text == null || text.trim().isEmpty){
                             return "Please this is required";
                           }else {
                             return null ;
                           }
                         },
                         cursorColor: Colors.orange,
                         keyboardType: TextInputType.text,
                         decoration: InputDecoration (
                           hintText: "Enter your email" ,
                           border: OutlineInputBorder (
                             borderRadius: BorderRadius.circular(20),
                           ),
                           fillColor: Colors.white,
                           filled: true ,
                           prefixIcon: Icon(Icons.email , color: Colors.orangeAccent,)
                         ),
                       ),
                       SizedBox(height: 20,),
                       TextFormField(
                         onChanged: (text){
                           password = text ;
                         },
                         validator: (text){
                           if (text == null || text.trim().isEmpty){
                             return "Please this is required" ;
                           }else {
                             return null ;
                           }
                         },
                         cursorColor: Colors.orange,
                         keyboardType: TextInputType.number,
                         decoration: InputDecoration (
                             hintText: "Enter your password" ,
                             border: OutlineInputBorder (
                               borderRadius: BorderRadius.circular(20),
                             ),
                             fillColor: Colors.white,
                             filled: true ,
                             prefixIcon: Icon(Icons.password , color: Colors.orangeAccent,)
                         ),
                       ),
                      SizedBox(height: 40,),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                            onPressed: (){
                                if (isChecked2 == true){
                                  login();
                                }else {
                                  var snackBar = SnackBar(content: Text ("Please check you are user or admin"));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }if (isChecked1 == true){
                                  loginAdmin();
                              }else {
                                  var snackBar = SnackBar(content: Text("Please check you are user or admin"));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            }, child: Text("Login") ,
                        style: ElevatedButton.styleFrom(primary: Colors.black , shape: StadiumBorder()),),
                      ) ,
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Don't have an account ? " , style: TextStyle(color: Colors.white ,
                               fontSize: 18),),
                           TextButton(
                               onPressed: (){
                                 navigateToRegisterScreen();
                               },
                               child: Text("Sign up" , style: TextStyle(color: Colors.black ,
                                   fontSize: 18),),)

                         ],
                       ) ,
                       SizedBox(height: 20,) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children : [
                                Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                    value: isChecked1,
                                    onChanged: (value){
                                      if (value != null){
                                        isChecked1 = value ;
                                        setState ((){});
                                      }

                                    }) ,
                                Text ("Iam an admin" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)
                              ]
                          ) ,

                          Row (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children : [
                                Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                    value: isChecked2,
                                    onChanged: (value){
                                      if (value != null){
                                        isChecked2 = value ;
                                        setState ((){});
                                      }
                                    }) ,
                                Text ("Iam a user" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),)
                              ]
                          ) ,
                        ],
                      )
                     ],
                   ),
                 ),
               )),
         ),
        ),
      ),
    );
  }

  @override
  void navigateToRegisterScreen() {
    Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
  }

  void login() {
    if (formKey.currentState?.validate() == true){
   viewModel.loginFun(email, password);
    }
    }
  void loginAdmin(){
    if (formKey.currentState?.validate() == true){
      viewModel.loginFunAdmin(email, password);
    }
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Row (
            children: [
              Text("Loading"),
              CircularProgressIndicator(
                color: Colors.orange,
              ),
            ],
          )
        ));
  }

  @override
  void showMessage(String message) {
   showDialog(
       context: context,
       builder: (context) => AlertDialog(
         content: Text(message),
         actions: [
           TextButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               child: Text ("ok"))
         ],
       ));
  }

  @override
  void navigateToMajor(UserModel userModel) {
    var provider = Provider.of<UserProvider>(context , listen: false);
    provider.user = userModel ;
    Navigator.pushReplacementNamed(context, MajorScreen.routeName);
  }

  @override
  void navigateToAdminScreen() {
    Navigator.pushReplacementNamed(context, AdminScreen.routeName);
  }
}
