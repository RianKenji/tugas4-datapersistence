class Pizza {
  late int id;
  late String pizzaName;
  late String description;
  late double price;
  late String imageUrl;


  Pizza.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.pizzaName = json['pizzaName'];
    this.description = json['description'];
    this.price = json['price'];
    this.imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': pizzaName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

}


