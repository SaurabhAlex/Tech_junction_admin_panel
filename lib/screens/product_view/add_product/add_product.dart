import 'dart:io';
import 'package:admin_tech/models/category_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../firebase/firebase_storage/firebase_storage.dart';
import '../../../models/product_model/product_model.dart';
import '../../../provider/app_provider.dart';
import '../../../widgets/primary_button/primary_button.dart';

class AddProduct extends StatefulWidget {

  const AddProduct({Key? key, }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

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
    CategoryModel? _selectCategory;
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text("Add Product",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                radius: 100,
                backgroundImage: FileImage(image!),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "Product name",
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: desc,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: "description",
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Price",
              ),
            ),
            DropdownButtonFormField(
                value: _selectCategory,
                hint: const Text("Please select category"),
                isExpanded: true,
                onChanged: (value){

                    _selectCategory = value;

                },

                items: appProvider.getCategoriesList.map((CategoryModel val) =>
                    DropdownMenuItem(
                      value: val,
                      child: Text(val.name),
                    )).toList()
            ),
            const SizedBox(height: 20,),
            PrimaryButton(
              title: "Add",
              onPressed: () async{
                if(image == null || name.text.isEmpty || desc.text.isEmpty || price.text.isEmpty || _selectCategory ==null ){
                  showMessage("Please fill all Details");
                }
                else {
                  appProvider.addProduct(
                      image!,
                      name.text,
                      _selectCategory!.id,
                      price.text,
                      desc.text
                  );
                  showMessage("Product added successfully");
                  Navigator.pop(context);
                }
                showMessage("Error found successfully");
              },
            )
          ],
        ),
      ),
    );
  }
}
