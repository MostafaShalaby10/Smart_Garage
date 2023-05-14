class DataModel {
  String? period;
  String? price;
  String? email;
  String? name;
  String? phone;
  String? location;
  String? id;
  String? date;
  String? rate ;

  DataModel({
    this.email,
    this.phone,
    this.name,
    this.period,
    this.price,
    this.location,
    this.id,
    this.date,
    this.rate,
  });

  DataModel.fromjson(Map<dynamic, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    price = json['price'];
    period = json['period'];
    name = json['name'];
    location = json['location'];
    id = json['id'];
    date = json['date'];
    rate = json['rate'];
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,
      "price": price,
      "period": period,
      "phone": phone,
      "email": email,
      "location": location,
      "id": id,
      "date": date,
      "rate": rate,
    };
  }
}
