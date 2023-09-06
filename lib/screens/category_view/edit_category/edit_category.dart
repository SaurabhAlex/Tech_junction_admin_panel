import 'dart:io';
import 'package:admin_tech/constants/constants.dart';
import 'package:admin_tech/firebase/firestore_helper/firestore_helper.dart';
import 'package:admin_tech/models/category_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../firebase/firebase_storage/firebase_storage.dart';
import '../../../models/user_model/user_model.dart';
import '../../../provider/app_provider.dart';
import '../../../widgets/primary_button/primary_button.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;
  const EditCategory({Key? key, required this.index, required this.categoryModel}) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {

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
        title:const Text("Edit Category",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                hintText: widget.categoryModel.name,
              ),
            ),
            const SizedBox(height: 20,),
            PrimaryButton(
              title: "Update",
              onPressed: () async{
                if(image == null && name.text.isEmpty){
                  Navigator.of(context).pop();
                }
                else if(image != null){
                  String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(widget.categoryModel.id ,image!);
                  CategoryModel categoryModel = widget.categoryModel.copyWith(name: name.text.isEmpty? null:name.text, image: imageUrl);
                  appProvider.updateCategoryList(widget.index, categoryModel);
                  showMessage("Category Updated Successfully");
                }else{
                  CategoryModel categoryModel = widget.categoryModel.copyWith(name: name.text);
                  appProvider.updateCategoryList(widget.index, categoryModel);
                  showMessage("Category Updated Successfully");
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
