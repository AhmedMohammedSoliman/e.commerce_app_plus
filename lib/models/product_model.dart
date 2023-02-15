class ProductModel {
  String name ;
  String id ;
  String description ;
  String category ;
  String image ;
  String price ;

  ProductModel ({
    required this.name , required this.category , required this.image , required this.description ,
    this.id = "" , required this.price
});

  ProductModel.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    description: json['description']! as String,
    category: json['category']! as String,
    image: json['image']! as String,
    price: json['price']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      "description" : description ,
      "category" : category ,
      "image" : image,
      "price" : price
    };
  }

}