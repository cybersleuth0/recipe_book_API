import 'package:flutter/material.dart';
import 'package:recipes_via_api/Models/models.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});


  @override
  State<DetailsScreen> createState() => _DetailsSreenState();
}

class _DetailsSreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    RecipeModel recipe = args["recipe"];
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [Text("${recipe.caloriesPerServing}")]),
      ),
    );
  }
}
