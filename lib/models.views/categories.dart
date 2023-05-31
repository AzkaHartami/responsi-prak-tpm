import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'lists.dart';

class Category extends StatefulWidget{

@override 
_CategoryState createState() => _CategoryState(); 
}

class _CategoryState extends State<Category> {

List<String> categories = [];
List<String> categoryImages = [];

@override
void initState(){
  super.initState();
  fetchCategories();
}

 void fetchCategories() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    final data = json.decode(response.body);
    setState(() {
      categories = List<String>.from(data['categories'].map((category) => category['strCategory']));
      categoryImages = List<String>.from(data['categories'].map((category) => category['strCategoryThumb']));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text(
                 'Food Categories',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListMakananPage(category: categories[index]),
                ),
              );
            },
            child: Card(
              child: Row(
                children: [
                  Image.network(
                    categoryImages[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Text(
                    categories[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}