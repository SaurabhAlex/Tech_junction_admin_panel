import 'package:admin_tech/provider/app_provider.dart';
import 'package:admin_tech/screens/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants/theme.dart';
import 'firebase/firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider()..getUserListTable()..getCategoriesListTable(),
      child: MaterialApp(
        title: 'Tech Junction Admin Panel',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const HomeScreen(),
      ),
    );
  }
}
