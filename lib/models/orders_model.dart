import 'package:e_commerce_tharwat_samy/models/product_model.dart';

class OrdersModel {
  String id ;
  List <ProductModel> products ;
  int totalPrice ;
  String location ;

  OrdersModel ({this.id = "" ,required this.products , required this.totalPrice , required this.location});

  OrdersModel.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    products: json['products']! as List <ProductModel>,
    totalPrice: json['price']! as int,
    location: json['location']! as String,


  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'products' : products,
      'price' : totalPrice,
      'location' : location ,
    };
  }
 }