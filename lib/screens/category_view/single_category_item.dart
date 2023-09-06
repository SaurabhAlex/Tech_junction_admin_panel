import 'package:admin_tech/screens/category_view/edit_category/edit_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../models/category_model/category_model.dart';
import '../../provider/app_provider.dart';

class SingleCategoryItem extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;
  const SingleCategoryItem({Key? key, required this.singleCategory, required this.index}) : super(key: key);

  @override
  State<SingleCategoryItem> createState() => _SingleCategoryItemState();
}

class _SingleCategoryItemState extends State<SingleCategoryItem> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(widget.singleCategory.image)
                  ),
                  Text(
                    widget.singleCategory.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),)
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push(EditCategory(index: widget.index, categoryModel: widget.singleCategory), context);
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
                        await appProvider.deleteCategoryFromFirebase(widget.singleCategory);
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
