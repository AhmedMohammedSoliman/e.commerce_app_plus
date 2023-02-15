class UserModel {
  String id ;
  String userName ;
  String email ;

  UserModel ({required this.id  , required this.email , required this.userName });
  UserModel.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    userName: json['user_name']! as String,
    email: json['email']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'user_name': userName,
      "email" : email
    };
  }
}