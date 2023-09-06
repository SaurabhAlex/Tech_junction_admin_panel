import 'package:admin_tech/screens/product_view/edit_product/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../models/product_model/product_model.dart';
import '../../provider/app_provider.dart';

class SingleProductView extends StatefulWidget {
  final ProductModel singleProduct;
  final int index;

  const SingleProductView({Key? key, required this.singleProduct, required this.index}) : super(key: key);

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {

    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      color:  Colors.white,
      elevation: 14,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Center(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(widget.singleProduct.image, height: 120,width: 100,),
                  Text( widget.singleProduct.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  Text("Price: \u{20B9}${widget.singleProduct.price}",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                    ),),
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push( EditProduct(index: widget.index, productModel: widget.singleProduct,), context);
                    },
                    child: const Icon(Icons.edit, color: Colors.purple,),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async{
                        setState(() {
                          isLoading= true;
                        });
                        await appProvider.deleteProductFromFirebase(widget.singleProduct);
                        setState(() {
                          isLoading= false;
                        });
                      },
                      child: isLoading? const Center(
                        child: CircularProgressIndicator(),
                      ):const Icon(Icons.delete, color: Colors.red,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );;
  }
}
