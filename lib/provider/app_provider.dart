import 'dart:io';

import 'package:admin_tech/constants/constants.dart';
import 'package:admin_tech/models/category_model/category_model.dart';
import 'package:admin_tech/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import '../firebase/firestore_helper/firestore_helper.dart';
import '../models/user_model/user_model.dart';

class AppProvider with ChangeNotifier{

  List<UserModel> _userList = [];
  List<CategoryModel> _categoriesList = [];
  List<ProductModel> _productList = [];


  Future<void> getUserListTable () async{
    _userList = await FirestoreHelper.instance.getUserList();
  }

  List<UserModel> get getUserList => _userList;


  Future<void> getCategoriesListTable () async{
    _categoriesList = await FirestoreHelper.instance.getCategoriesList();
  }


  // /user///


  Future<void> deleteUserFromFirebase(UserModel userModel) async{
    String value = await FirestoreHelper.instance.deleteSingleUser(userModel.id.toString());
    if(value == "Successfully Deleted"){
      _userList.remove(userModel);
      showMessage("User Successfully Deleted");
    }
    notifyListeners();
  }


  void updateUserList( int index ,UserModel userModel) async{
    await FirestoreHelper.instance.updateUser(userModel);
    _userList[index] = userModel;
    notifyListeners();
  }


  // /category///

  Future<void> deleteCategoryFromFirebase(CategoryModel categoryModel) async{
    String value = await FirestoreHelper.instance.deleteSingleCategory(categoryModel.id.toString());
    if(value == "Successfully Deleted"){
      _categoriesList.remove(categoryModel);
      showMessage("Category Successfully Deleted");
    }
    notifyListeners();
  }


  void updateCategoryList( int index ,CategoryModel categoryModel) async{
    await FirestoreHelper.instance.updateSingleCategory(categoryModel);
    _categoriesList[index] = categoryModel;
    notifyListeners();
  }

  void addCategory(File image, String name) async{
    CategoryModel categoryModel =  await FirestoreHelper.instance.addSingleCategory(image, name);
    _categoriesList.add(categoryModel);
    notifyListeners();
  }



  List<CategoryModel> get getCategoriesList => _categoriesList;
  List<ProductModel> get getProducts => _productList;


  Future<void> callBackFunction() async{
    await getUserListTable();
    await getCategoriesListTable();
    await getProduct();
  }

    //Products//


  Future<void> getProduct() async{
 _productList = await FirestoreHelper.instance.getProducts();
    notifyListeners();
  }


  Future<void> deleteProductFromFirebase(ProductModel productModel) async{
    String value = await FirestoreHelper.instance.deleteProduct(productModel.categoryId, productModel.id);
    if(value == "Successfully Deleted"){
      _productList.remove(productModel);
      showMessage("Product Successfully Deleted");
    }
    notifyListeners();
  }

  void updateProductList( int index ,ProductModel productModel) async{
    await FirestoreHelper.instance.updateSingleProduct(productModel);
    _productList[index] = productModel;
    notifyListeners();
  }


}



