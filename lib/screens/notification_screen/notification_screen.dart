import 'dart:convert';
import 'package:admin_tech/widgets/primary_button/primary_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../provider/app_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                hintText: "Notification title"
              ),
            ),
            const SizedBox(height: 12,),
            TextFormField(
              controller: _body,
              decoration: const InputDecoration(
                  hintText: "Notification body"
              ),
            ),
            const SizedBox(height: 12,),
            PrimaryButton(
              title: "Send Notification",
              onPressed: () {
                if(_body.text.isNotEmpty && _title.text.isNotEmpty){
                  sendNotification(appProvider.getUsersToken, _title.text, _body.text);
                  _title.clear();
                  _body.clear();
                }else{
                  showMessage("Please fill all the above details");
                }

              },
            )
          ],
        ),
      ),
    );
  }
}


Future<void> sendNotification(List<String?> usersToken, String title, String body) async{
  List<String> newAllUsersToken = [];
  List<String> allUsersToken = [];
  for(var element in usersToken){
    if(element != null || element != ""){
      newAllUsersToken.add(element!);
    }
  }
  allUsersToken = newAllUsersToken;
  const String serverKey = 'AAAAowRUxvo:APA91bEIoBhlHvrnLl4zqidMcnHoqpqK6IXQsMolaAlh8iL-HfUrJl5Tdx2jhn1rSmKtDCnMDCec9DP-tQJdCC3XbJuUiLPxITaBiWqYn_sCEv9OotwzA8rPzOEEsGxv_xqoYQhrlvS_';

  const String firebaseUrl = 'https://fcm.googleapis.com/fcm/send';


  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey'
  };

  final Map<String, dynamic> notification = {
    'title': title,
    'body': body
  };

  final Map<String, dynamic> requestBody = {
    'notification': notification,
    'priority': 'high',
    'registration_ids': allUsersToken
  };

  final String encodedBody = jsonEncode(requestBody);

  final http.Response response = await http.post(
      Uri.parse(firebaseUrl),
      headers: headers,
      body: encodedBody
  );


  if(response.statusCode == 200){
    print("Notification sent successfully.");
  }else{
    print("Notification sending failed with status: ${response.statusCode}");
  }
}
