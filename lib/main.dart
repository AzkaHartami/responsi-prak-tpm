import 'package:flutter/material.dart';
import 'package:responsi/models.views/categories.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makanan App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Category(),
    );
  }
}