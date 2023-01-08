import 'package:flutter/material.dart';

class InstaProfileScreen extends StatefulWidget {
  InstaProfileScreen({Key? key}) : super(key: key);

  @override
  State<InstaProfileScreen> createState() => _InstaProfileScreenState();
}

class _InstaProfileScreenState extends State<InstaProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('프로필페이지'),
    );
  }
}
