import 'package:admin_tech/models/user_model/user_model.dart';
import 'package:admin_tech/provider/app_provider.dart';
import 'package:admin_tech/screens/users_view/single_user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users View"),
        centerTitle: true,
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child){
          return ListView.builder(
            padding: const EdgeInsets.all(5),
              itemCount: value.getUserList.length,
              itemBuilder: (context, index){
                UserModel userModel = value.getUserList[index];
                return SingleUserCard(userModel: userModel, index: index, );
              }
          );
        },
      )
    );
  }
}
