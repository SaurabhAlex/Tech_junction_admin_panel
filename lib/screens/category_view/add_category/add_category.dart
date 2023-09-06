import 'dart:io';
import 'package:admin_tech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../provider/app_provider.dart';
import '../../../widgets/primary_button/primary_button.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key,}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

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
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text("Add Category",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
              decoration: const InputDecoration(
                hintText: "Category Name",
              ),
            ),
            const SizedBox(height: 20,),
            PrimaryButton(
              title: "Add",
              onPressed: () async{
                if(image == null && name.text.isEmpty){
                  Navigator.of(context).pop();
                }
                else if(image != null && name.text.isNotEmpty){
                   appProvider.addCategory(image!, name.text);
                  showMessage("Category Added Successfully");
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
