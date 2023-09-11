import 'package:admin_tech/widgets/single_order_widget/single_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order_model/order_model.dart';
import '../../provider/app_provider.dart';

class OrderList extends StatelessWidget {
  final String title;
  const OrderList({Key? key, required this.title}) : super(key: key);

  List<OrderModel> getOrderList(AppProvider appProvider){
    if(title == "Pending"){
      return appProvider.getPendingOrderList;
    }else if(title == "Completed"){
      return appProvider.getCompletedOrderList;
    }else if(title == "cancel"){
      return appProvider.getCancelOrderList;
    }else if(title == "Delivery"){
      return appProvider.getDeliveryOrderList;
    }else{
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("$title Order List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:getOrderList(appProvider).isEmpty
          ? Center(
          child: Text("$title is Empty"),
        )
        :ListView.builder(
          itemCount: getOrderList(appProvider).length,
            itemBuilder: (context, index){
            OrderModel orderModel = getOrderList(appProvider)[index];
            return SingleOerderWidget(orderModel: orderModel);
            }
        ),
      ),
    );
  }
}
