import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../firebase/firebase_storage/firebase_storage.dart';
import '../../../models/product_model/product_model.dart';
import '../../../provider/app_provider.dart';
import '../../../widgets/primary_button/primary_button.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  final int index;
  const EditProduct({Key? key, required this.index, required this.productModel}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  final _picker = ImagePicker();
  File? image;

  Future takePicture() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80, );

    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {
      });
    }else{
      print("No image selected");
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController desc = TextEditingController();
    TextEditingController price = TextEditingController();
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text("Edit Product",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            image == null ?
            InkWell(
              onTap: () {
                takePicture();
              },
              child: const CircleAvatar(
                  radius: 80,
                  child:
                  Icon(Icons.camera_alt_outlined, size: 35,)
              ),
            ):
            InkWell(
              onTap: () {
                takePicture();
              },
              child: CircleAvatar(
                radius: 120,
                backgroundImage: FileImage(image!),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: widget.productModel.name,
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: desc,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: widget.productModel.desc,
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "\u{20B9}${widget.productModel.price.toString()}",
              ),
            ),
            const SizedBox(height: 20,),
            PrimaryButton(
              title: "Update",
              onPressed: () async{
                if(image == null && name.text.isEmpty && desc.text.isEmpty && price.text.isEmpty){
                  Navigator.of(context).pop();
                }
                else if(image != null){
                  String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(widget.productModel.id ,image!);
                  ProductModel productModel = widget.productModel.copyWith(
                      name: name.text.isEmpty? null:name.text,
                      desc: desc.text.isEmpty? null:desc.text,
                      price: price.text.isEmpty? null:price.text,
                      image: imageUrl);
                  appProvider.updateProductList(widget.index, productModel);
                  showMessage("Product Updated Successfully");
                }else{
                  ProductModel productModel = widget.productModel.copyWith(
                      name: name.text.isEmpty? null:name.text,
                      desc: desc.text.isEmpty? null:desc.text,
                      price: price.text.isEmpty? null:price.text,
                  );
                  appProvider.updateProductList(widget.index, productModel);
                  showMessage("Product Updated Successfully");
                }
                Navigator.pop(context);

              },
            )
          ],
        ),
      ),
    );
  }
}
