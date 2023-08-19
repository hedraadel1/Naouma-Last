class UserDataModel{
  final int id;
  final String name;
  final String phone;
  final String email;
  final String image;

  UserDataModel({this.id, this.name, this.phone, this.email, this.image});

  factory UserDataModel.fromJson(json) {
   return UserDataModel(
     id: json["id"],
     phone: json["phone"],
      email: json["email"],
     name: json['name'],
     image: json['image'],
   );
 }
}