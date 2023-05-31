import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class DetailMakananPage extends StatefulWidget {
  final String food;

  DetailMakananPage({required this.food});

  @override
  _DetailMakananPageState createState() => _DetailMakananPageState();
}

class _DetailMakananPageState extends State<DetailMakananPage> {
  Map<String, dynamic> foodDetails = {};

  @override
  void initState() {
    super.initState();
    fetchFoodDetails();
  }

  void fetchFoodDetails() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=${widget.food}'));
    final data = json.decode(response.body);
    setState(() {
      foodDetails = data['meals'][0];
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
              'Detail Foods',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: foodDetails.isNotEmpty
          ? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    foodDetails['strMeal'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Image.network(foodDetails['strMealThumb'], height: 250, width: 450,),
                  SizedBox(height: 16.0),
                  Text('Category : ' + foodDetails['strCategory']),
                  Text('Area : ' + foodDetails['strArea']),
                  SizedBox(height: 16.0),
                  Text(foodDetails['strInstructions']),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      launch(foodDetails['strYoutube']);
                    },
                    child: Text('Watch video from YouTube'),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}