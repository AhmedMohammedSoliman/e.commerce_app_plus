import 'package:e_commerce_tharwat_samy/features/major_screen/major_screen.dart';
import 'package:e_commerce_tharwat_samy/features/register_screen/regiser_screen_navigator.dart';
import 'package:e_commerce_tharwat_samy/features/register_screen/register_screen_view_model.dart';
import 'package:e_commerce_tharwat_samy/models/user_model.dart';
import 'package:e_commerce_tharwat_samy/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register" ;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator {
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();
  var formKey = GlobalKey<FormState>();
  String email = "";
  String password = "" ;
  String userName = "" ;
  @override
  void initState() {
   viewModel.navigator = this ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
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
                            userName = text ;
                          },
                          validator: (text){
                            if (text == null || text.trim().isEmpty){
                              return "Please this is required" ;
                            }else {
                              return null ;
                            }
                          },
                          cursorColor: Colors.orange,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration (
                              hintText: "Enter your user name" ,
                              border: OutlineInputBorder (
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.white,
                              filled: true ,
                              prefixIcon: Icon(Icons.person , color: Colors.orangeAccent,)
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          onChanged: (text){
                            email = text ;
                          },
                          validator: (text){
                            if (text == null || text.trim().isEmpty){
                              return "Please this is required" ;
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
                              signUp ();
                            }, child: Text("Sign up") ,
                            style: ElevatedButton.styleFrom(primary: Colors.black , shape: StadiumBorder()),),
                        ) ,
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (formKey.currentState?.validate() == true){
   viewModel.signUpFun(email, password , userName);
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
}
