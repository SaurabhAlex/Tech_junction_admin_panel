import 'package:admin_tech/models/category_model/category_model.dart';
import 'package:admin_tech/screens/category_view/add_category/add_category.dart';
import 'package:admin_tech/screens/category_view/single_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/app_provider.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Categories View"),
          centerTitle: true,
          actions: [
            IconButton(
            onPressed: () {
              Routes.instance.push(const AddCategory(), context);
            },
        icon: const Icon(Icons.add_circle_outline_rounded))
          ],
        ),
        body: Consumer<AppProvider>(
          builder: (context, value, child){
            return SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1
                ),
                  itemCount: value.getCategoriesList.length,
                  itemBuilder: (context, index){
                    CategoryModel categoryModel = value.getCategoriesList[index];
                    return  SingleCategoryItem(singleCategory: categoryModel, index: index,);

                  },
              ),
            );
          },
        )
    );;
  }
}
