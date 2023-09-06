
import '../product_model/product_model.dart';


class OrderModel {
  OrderModel({
    required this.payment,
    required this.status,
    required this.products,
    required this.totalPrice,
    required this.orderId,

  });

  String payment;
  String status;
  List<ProductModel> products;
  double totalPrice;
  String orderId;
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap= json["products"];
    return OrderModel(
      orderId: json["orderId"],
      totalPrice:json["totalPrice"],
      payment: json["payment"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      status:json["status"],

    );
  }

}