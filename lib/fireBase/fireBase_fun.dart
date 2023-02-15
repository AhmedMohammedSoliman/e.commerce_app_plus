import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_tharwat_samy/models/product_model.dart';
import 'package:e_commerce_tharwat_samy/models/user_model.dart';

class FireBaseFuns {
 /// user
  static CollectionReference<UserModel> getUserCollectionFromFireBse (){
    return FirebaseFirestore.instance.collection('user').withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson()
    );
  }

  static Future<void> addUserToFireBase (UserModel userModel)async{
    return getUserCollectionFromFireBse().doc(userModel.id).set(userModel);
  }

  static Future<UserModel?> getUserFromFireBase (String userId)async{
    var documentSnapShot = await getUserCollectionFromFireBse().doc(userId).get();
    return documentSnapShot.data();
  }
  /// product
  static CollectionReference<ProductModel> getProductCollectionFromFireBase (){
    return FirebaseFirestore.instance.collection('product').withConverter<ProductModel>(
        fromFirestore: (snapshot, _) => ProductModel.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson()
    );
  }

  static Future <void> addProductToFireBase (ProductModel productModel){
   var collection = getProductCollectionFromFireBase();
   var doc = collection.doc();
   productModel.id = doc.id ;
  return doc.set(productModel);
  }
  static  Stream <QuerySnapshot <ProductModel>>getProductsFromFireBase (){
   return  getProductCollectionFromFireBase().snapshots();
  }
 static Future <void> updateProduct (String name , String description , String price , String category ,
     String productId , String image){
   return  getProductCollectionFromFireBase().doc(productId).update({
      "name" : name ,
       "description" : description,
       "price" : price ,
       "category" : category ,
        "image" : image
    });
  }

  static Future<void> deleteProductFromFireBase (String productId){
    return getProductCollectionFromFireBase().doc(productId).delete();
  }
}