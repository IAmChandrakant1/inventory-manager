class ProductModel {
  String id;
  String name;
  int quantity;
  double price;
  bool favorite;

  ProductModel(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.price,
      required this.favorite});

  /*factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'],
      quantity: data['quantity'],
      price: data['price'],
      favorite: data['favorite'] ?? false,
    );
  }*/

  factory ProductModel.fromMap(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      name: data['name'],
      quantity: data['quantity'],
      price: data['price'],
      favorite: data['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'favorite': favorite,
    };
  }
}
