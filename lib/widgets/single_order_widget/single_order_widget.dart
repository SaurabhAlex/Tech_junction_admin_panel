import 'package:admin_tech/constants/constants.dart';
import 'package:admin_tech/firebase/firestore_helper/firestore_helper.dart';
import 'package:admin_tech/models/order_model/order_model.dart';
import 'package:admin_tech/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class SingleOerderWidget extends StatefulWidget {
  final OrderModel orderModel;
  const SingleOerderWidget({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<SingleOerderWidget> createState() => _SingleOerderWidgetState();
}

class _SingleOerderWidgetState extends State<SingleOerderWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
          collapsedShape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,width: 2.3
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).primaryColor,width: 2.3
            ),),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                height: 150,
                width: 150,
                color:  Theme.of(context).primaryColor.withOpacity(0.5),
                child: Image.network(widget.orderModel.products[0].image),
              ),
              SizedBox(
                height: 140,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.orderModel.products[0].name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 12,),
                      widget.orderModel.products.length >1 ?
                      SizedBox.fromSize()
                      : Column(
                        children: [
                          Text("Quantity: ${widget.orderModel.products[0].qty.toString()}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
                          const SizedBox(height: 12,),
                        ],
                      ),
                      Text("Total Price: \$${widget.orderModel.totalPrice.toString()}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
                      const SizedBox(height: 12,),
                      Text("Order Status: ${widget.orderModel.status}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
                      const SizedBox(height: 12,),
                      widget.orderModel.status == "Pending"
                      ?CupertinoButton(
                        onPressed: () async{
                          await FirestoreHelper.instance.updateOrder(widget.orderModel, "Delivery");
                          widget.orderModel.status = "Delivery";
                          appProvider.updatePendingOrder(widget.orderModel);
                          setState(() { });
                        },
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: 48,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Text("Send to Delivery",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                          :SizedBox.fromSize(),
                      const SizedBox(height: 8,),
                      widget.orderModel.status == "Pending" || widget.orderModel.status == "Delivery"
                      ?CupertinoButton(
                        onPressed: () async{
                          if(widget.orderModel.status == "Pending"){
                            widget.orderModel.status = "cancel";
                            await FirestoreHelper.instance.updateOrder(widget.orderModel, "Cancel");
                            appProvider.updateCancelPendingOrder(widget.orderModel);
                          }else{
                            widget.orderModel.status = "cancel";
                            await FirestoreHelper.instance.updateOrder(widget.orderModel, "Cancel");
                            appProvider.updateCancelDeliveryOrder(widget.orderModel);
                          }
                          setState(() { });
                        },
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: 48,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Text("Cancel Order",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                          :SizedBox.fromSize(),
                    ],
                  ),
                ),
              )

            ],
          ),
        children: widget.orderModel.products.length >1 ?
      [
        const Text("Details"),
        const Divider(color: Colors.purple,),
        ...  widget.orderModel.products.map((singleProduct) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 6),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      color:  Theme.of(context).primaryColor.withOpacity(0.5),
                      child: Image.network(singleProduct.image),
                    ),
                    SizedBox(
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(singleProduct.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 12,),
                            Column(
                              children: [
                                Text("Quantity: ${singleProduct.qty.toString()}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
                                const SizedBox(height: 12,),
                              ],
                            ),
                            Text("Price: \$${singleProduct.price.toString()}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),

                          ],
                        ),
                      ),
                    )

                  ],
                ),
                const Divider(color: Colors.purple,)
              ],
            ),
          );
        }).toList()
      ]

            :[
          const Text("Empty")
        ],
      ),
    );
  }
}
