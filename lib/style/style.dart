import 'package:flutter/material.dart';

var theme = ThemeData(
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(backgroundColor: Colors.grey)),
    iconTheme: IconThemeData(color: Colors.black),
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        actionsIconTheme: IconThemeData(color: Colors.black, size: 30)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Colors.black),
      unselectedIconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)));
