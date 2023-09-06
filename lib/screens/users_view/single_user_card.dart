import 'package:admin_tech/models/user_model/user_model.dart';
import 'package:admin_tech/screens/users_view/edit_user/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/app_provider.dart';

class SingleUserCard extends StatefulWidget {
  final UserModel userModel;
  // final AppProvider appProvider;
  final int index;
  const SingleUserCard({Key? key, required this.userModel, required this.index, }) : super(key: key);

  @override
  State<SingleUserCard> createState() => _SingleUserCardState();
}

class _SingleUserCardState extends State<SingleUserCard> {

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.userModel.image != null
                ? CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.userModel.image!)
            )
                : const CircleAvatar(
              radius: 30,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.userModel.name == null
                    ? const Text("Unknown Users")
                    : Text(widget.userModel.name.toString()),
                Text(widget.userModel.email.toString()),
              ],
            ),
            const Spacer(),
            IconButton
              (onPressed: () {
             Routes.instance.push(EditUser(userModel: widget.userModel, index: widget.index,), context);
            },
                icon: const Icon(Icons.edit, color: Colors.purple,)),
            isLoading? const CircularProgressIndicator():

            IconButton
              (onPressed: () async{
                setState(() {
                  isLoading = true;
                });
              await appProvider.deleteUserFromFirebase(widget.userModel);
                setState(() {
                  isLoading = false;
                });
            },
                icon: const Icon(Icons.delete, color: Colors.red,))



          ],
        ),
      ),
    );
  }
}
