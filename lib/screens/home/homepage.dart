import 'package:admin_tech/constants/routes.dart';
import 'package:admin_tech/provider/app_provider.dart';
import 'package:admin_tech/screens/category_view/category_view.dart';
import 'package:admin_tech/screens/product_view/products_view.dart';
import 'package:admin_tech/screens/users_view/usersView.dart';
import 'package:admin_tech/widgets/singleDash_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = false;

  void getData()async{
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunction();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,

              ),
              const SizedBox(height: 4,),
              const Text("Saurabh Gupta"),
              const Text("Alex@gmail.com"),
              const SizedBox(height: 4,),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisCount: 2,
                padding: const EdgeInsets.only(top: 12),
                children:  [
                  SingleDashItem(
                    subtitle: "Users",
                    title: appProvider.getUserList.length.toString(),
                    onPressed: () {
                      Routes.instance.push(const UserView(), context);
                    },
                  ),
                  SingleDashItem(
                    subtitle: "Categories",
                    title: appProvider.getCategoriesList.length.toString(),
                    onPressed: () {
                      Routes.instance.push(const CategoriesView(), context);
                    },
                  ),
                  SingleDashItem(
                    subtitle: "Products",
                    title: appProvider.getProducts.length.toString(),
                    onPressed: () {
                      Routes.instance.push(const ProductsView(), context);
                    },
                  ),
                  SingleDashItem(
                    subtitle: "Earning",
                    title: "\$500",
                    onPressed: () {  },
                  ),
                  SingleDashItem(
                    subtitle: "Pending Orders",
                    title: "1",
                    onPressed: () {  }
                    ,),
                  SingleDashItem(
                    subtitle: "Completed Orders",
                    title: "2", onPressed: () {  },
                  ),
                  SingleDashItem(
                    subtitle: "Cancel Orders",
                    title: "2",
                    onPressed: () {  },
                  ),
                  SingleDashItem(
                    subtitle: "Delivered Orders",
                    title: "0",
                    onPressed: () {  },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
