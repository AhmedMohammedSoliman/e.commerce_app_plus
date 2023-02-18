class ProductModel {
  String name ;
  String id ;
  String description ;
  String category ;
  String image ;
  String price ;
  int count ;


  ProductModel ({
    required this.name , required this.category , required this.image , required this.description ,
    this.id = "" , required this.price , this.count = 0
});

  ProductModel.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    description: json['description']! as String,
    category: json['category']! as String,
    image: json['image']! as String,
    price: json['price']! as String,
    count: json['count']! as int,

  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      "description" : description ,
      "category" : category ,
      "image" : image,
      "price" : price ,
      "count" : count ,

    };
  }

}