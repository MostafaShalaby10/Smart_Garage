class UserModel {
  String? id;
  String? email;
  String? name;
  String? phone;

  UserModel({
    this.email,
    this.phone,
    this.name,
    this.id,
  });

  UserModel.fromjson(Map<dynamic, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,
      "id": id,
      "phone": phone,
      "email": email,
    };
  }
}
