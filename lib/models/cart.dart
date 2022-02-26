class Cart {
  String? name;
  double? price;
  String? url;

  Cart({this.name, this.price, this.url});

  Cart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = double.tryParse('${json['price']}');
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = double.tryParse('$price');
    data['url'] = url;
    return data;
  }
}
