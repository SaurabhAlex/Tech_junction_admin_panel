import 'dart:io';

import 'package:admin_tech/firebase/firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/constants.dart';
import '../../models/category_model/category_model.dart';
import '../../models/product_model/product_model.dart';
import '../../models/user_model/user_model.dart';

class FirestoreHelper {
  static FirestoreHelper instance = FirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<UserModel>> getUserList() async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection("users").get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<CategoryModel>> getCategoriesList() async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs.map((e) => CategoryModel.fromJson(e.data())).toList();


      return categoriesList;
    }catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleUser(String id) async{
    try{
      await _firebaseFirestore.collection("users").doc(id).delete();
      return "Successfully Deleted";
    }catch(e){
      return e.toString();
    }
  }

  Future<void> updateUser(UserModel userModel) async{
    try{
      await _firebaseFirestore.collection("users").doc(userModel.id).update(userModel.toJson());
    }catch(e){
    }
  }


  Future<String> deleteSingleCategory(String id) async{
    try{
      await _firebaseFirestore.collection("categories").doc(id).delete();
      return "Successfully Deleted";
    }catch(e){
      return e.toString();
    }
  }

  Future<void> updateSingleCategory(CategoryModel categoryModel) async{
    try{
      await _firebaseFirestore.collection("categories").doc(categoryModel.id).update(categoryModel.toJson());
    }catch(e){
    }
  }

  Future<CategoryModel> addSingleCategory(File image, String name) async{
    DocumentReference reference =
    _firebaseFirestore.collection("categories").doc();
    String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(reference.id, image);
    CategoryModel addCategory = CategoryModel(image: imageUrl, id: reference.id, name: name);
    await reference.set(addCategory.toJson());
    return addCategory;
  }


  //Products//


  Future<List<ProductModel>> getProducts() async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup("products").get();
    List<ProductModel> productList =
        querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    return productList;
  }

  Future<String> deleteProduct(String categoryId, String productId) async{
    try{
      await _firebaseFirestore.collection("categories").doc(categoryId).collection("products").doc(productId).delete();
      return "Successfully Deleted";
    }catch(e){
      return e.toString();
    }
  }


  Future<String> updateSingleProduct(ProductModel productModel) async{
    try{
      await _firebaseFirestore.collection("categories").doc(productModel.categoryId).collection("products").doc(productModel.id).update(productModel.toJson());
      return "Successfully Deleted";
    }catch(e){
      return e.toString();
    }
  }



  
}