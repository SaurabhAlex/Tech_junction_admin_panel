
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      )
  ),
  primaryColor: Colors.purpleAccent,
  canvasColor: Colors.purpleAccent,
  primarySwatch: Colors.purple,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          foregroundColor: Colors.purpleAccent,
          side: const BorderSide(
            color: Colors.green,
            width: 2,
          ),
          disabledForegroundColor: Colors.red.withOpacity(0.4)
      )
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    prefixIconColor: Colors.grey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          textStyle: const TextStyle(
              fontSize: 18
          ),
          disabledBackgroundColor: Colors.grey
      )
  ),

);