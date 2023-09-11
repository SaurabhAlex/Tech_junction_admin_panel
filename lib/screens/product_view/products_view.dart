import 'package:admin_tech/screens/product_view/add_product/add_product.dart';
import 'package:admin_tech/screens/product_view/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../models/product_model/product_model.dart';
import '../../provider/app_provider.dart';


class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance.push(const AddProduct(), context);
              },
              icon: const Icon(Icons.add_circle_outline_rounded))
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: appProvider.getProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.8
            ),
            itemBuilder: (context, index){
              ProductModel singleProduct = appProvider.getProducts[index];
              return SingleProductView(singleProduct: singleProduct, index: index,);
            }
        ),
      )
    );
  }
}
