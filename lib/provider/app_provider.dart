import 'dart:io';

import 'package:admin_tech/constants/constants.dart';
import 'package:admin_tech/models/category_model/category_model.dart';
import 'package:admin_tech/models/order_model/order_model.dart';
import 'package:admin_tech/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import '../firebase/firestore_helper/firestore_helper.dart';
import '../models/user_model/user_model.dart';

class AppProvider with ChangeNotifier{

  List<UserModel> _userList = [];
  List<CategoryModel> _categoriesList = [];
  List<ProductModel> _productList = [];
  List<OrderModel> _completedOrderList = [];
  List<OrderModel> _cancelOrderList  = [];
  List<OrderModel> _pendingOrderList  = [];
  List<OrderModel> _deliveryOrderList  = [];
  List<String?> _usersToken  = [];

  double _totalEarning = 0.0;
  Future<void> getUserListTable () async{
    _userList = await FirestoreHelper.instance.getUserList();
    _usersToken = _userList.map((e) => e.notificationToken).toList();
  }

  Future<void> getCompletedOrder () async{
    _completedOrderList = await FirestoreHelper.instance.getCompletedOrder();
    for(var element in _completedOrderList){
      _totalEarning += element.totalPrice;
    }
    notifyListeners();
  }

  Future<void> getCancelOrder()async{
    _cancelOrderList = await FirestoreHelper.instance.getCancelOrder();
    notifyListeners();
  }

  Future<void> getPendingOrder()async{
    _pendingOrderList = await FirestoreHelper.instance.getPendingOrder();
    notifyListeners();
  }

  Future<void> getDeliveryOrder()async{
    _deliveryOrderList = await FirestoreHelper.instance.getDeliveryOrder();
    notifyListeners();
  }

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


  List<UserModel> get getUserList => _userList;
  List<CategoryModel> get getCategoriesList => _categoriesList;
  List<ProductModel> get getProducts => _productList;
  List<OrderModel> get getCompletedOrderList => _completedOrderList;
  List<OrderModel> get getCancelOrderList => _cancelOrderList;
  List<OrderModel> get getPendingOrderList => _pendingOrderList;
  List<OrderModel> get getDeliveryOrderList => _deliveryOrderList;
  List<String?> get getUsersToken => _usersToken;
  double get getTotalEarning => _totalEarning;


  Future<void> callBackFunction() async{
    await getUserListTable();
    await getCategoriesListTable();
    await getProduct();
    getCompletedOrder();
    getCancelOrder();
    getPendingOrder();
    await getDeliveryOrder();
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



  void addProduct(
      File image,
      String name,
      String categoryId,
      String price,
      String desc) async{
    ProductModel productModel =  await FirestoreHelper.instance.addSingleProduct(
        image, name, categoryId, price, desc
    );
    _productList.add(productModel);
    notifyListeners();
  }

  void updatePendingOrder( OrderModel order) async{
   _deliveryOrderList.add(order);
   _pendingOrderList.remove(order);
   notifyListeners();
   showMessage("Send to Delivery");
  }

  void updateCancelPendingOrder( OrderModel order) async{
    _cancelOrderList.add(order);
    _pendingOrderList.remove(order);
    notifyListeners();
    showMessage("Successfully cancel");
  }

  void updateCancelDeliveryOrder( OrderModel order) async{
    _cancelOrderList.add(order);
    _deliveryOrderList.remove(order);
    notifyListeners();
    showMessage("Successfully cancel");
  }


}



