import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi/models.views/details.dart';
// import 'package:responsi/details.dart';

class ListMakananPage extends StatefulWidget {
  final String category;

  ListMakananPage({required this.category});

  @override
  _ListMakananPageState createState() => _ListMakananPageState();
}

class _ListMakananPageState extends State<ListMakananPage> {
  List<String> foods = [];
  List<String> foodsimage = [];

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  void fetchFoods() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.category}'));
    final data = json.decode(response.body);
    setState(() {
      foods = List<String>.from(data['meals'].map((food) => food['strMeal']));
      foodsimage = List<String>.from(data['meals'].map((food) => food['strMealThumb']));
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
                 'Food Lists',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMakananPage(food: foods[index]),
                ),
              );
            },
            child: Card(
                child: Row(
                  children: [
                    Image.network(
                      foodsimage[index],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(foods[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                  ],
                )
            )
          );
        },
      ),
    );
  }
}