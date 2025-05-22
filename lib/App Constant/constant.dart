import 'package:flutter/cupertino.dart';

import '../DetailsScreen.dart';
import '../HomeScreen.dart';

class AppRoutes {
  static const String ROUTE_HOME = "/Homepage";
  static const String ROUTE_RECIPE_DETAILS = "/RecipeDetails";

  static Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_HOME: (context) => HomeScreen(),
    ROUTE_RECIPE_DETAILS: (context) => DetailsScreen(),
  };
}
