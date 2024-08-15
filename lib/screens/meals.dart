import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MeansScreen extends StatelessWidget {
  final String title;
  final List<Meal> meals;

  const MeansScreen({super.key, required this.title, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
