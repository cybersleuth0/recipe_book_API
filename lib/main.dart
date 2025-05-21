import 'package:flutter/material.dart';
import 'package:recipes_via_api/HomeScreen.dart';

import 'DetailsScreen.dart';

void main() {
  runApp(
      MaterialApp(
          initialRoute: "/Homepage",
          routes: {
            "/Homepage": (context) => HomeScreen(),
            "/RecipeDetails": (context) => DetailsScreen(),
          },
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false));
}
