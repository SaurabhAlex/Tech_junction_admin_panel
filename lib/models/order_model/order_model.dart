
import '../product_model/product_model.dart';


class OrderModel {
  OrderModel({
    required this.payment,
    required this.status,
    required this.products,
    required this.totalPrice,
    required this.orderId,
    required this.userId

  });

  String payment;
  String status;
  List<ProductModel> products;
  double totalPrice;
  String orderId;
  String userId;
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap= json["products"];
    return OrderModel(
      orderId: json["orderId"],
      userId: json["userId"],
      totalPrice:json["totalPrice"],
      payment: json["payment"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      status:json["status"],

    );
  }

}