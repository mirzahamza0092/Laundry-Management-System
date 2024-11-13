class productListModel {
  final String id;
  final String name;
  final String quantity;

  productListModel({required this.id, required this.name, required this.quantity});
  Map<String, dynamic> toJson() => {
    "productId": id,
    "quantity": quantity,
  };
}

