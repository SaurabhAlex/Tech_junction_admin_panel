import 'dart:io';
import 'package:admin_tech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../firebase/firebase_storage/firebase_storage.dart';
import '../../../models/user_model/user_model.dart';
import '../../../provider/app_provider.dart';
import '../../../widgets/primary_button/primary_button.dart';

class EditUser extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const EditUser({Key? key, required this.userModel, required this.index}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

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
        title:const Text("Edit Profile",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                hintText: widget.userModel.name,
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
                  String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(widget.userModel.id ,image!);
                  UserModel userModel = widget.userModel.copyWith(name: name.text.isEmpty? null:name.text, image: imageUrl);
                  appProvider.updateUserList(widget.index, userModel);
                  showMessage("User Updated Successfully");
                }else{
                  UserModel userModel = widget.userModel.copyWith(name: name.text);
                  appProvider.updateUserList(widget.index, userModel);
                  showMessage("User Updated Successfully");
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
