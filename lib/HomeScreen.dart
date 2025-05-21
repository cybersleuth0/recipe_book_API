import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:recipes_via_api/Models/models.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<RecipeDataModel>? _recipesFuture;

  Future<RecipeDataModel> fetchRecipesData() async {
    const String baseUrl = "https://dummyjson.com/recipes";
    var response = await http.get(Uri.parse(baseUrl));
    return RecipeDataModel.fromJson(jsonDecode(response.body));
  }

  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _recipesFuture = fetchRecipesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffacd), // Light yellow background
      appBar: _buildAppBar(context), // Extracted app bar to a separate method
      body: _buildBody(), // Extracted body to a separate method
    );
  }

  /// Builds the custom app bar with search functionality
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffF0EAD6), // Cream color
      elevation: 0, // Remove shadow
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Recipe Book title
          Expanded(
            child: Text(
              "Recipe Book",
              style: GoogleFonts.poppins(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                height: 5,
              ),
            ),
          ),

          // Spacer when search is visible
          if (_isSearchVisible) Spacer(),

          // Animated search field/icon
          Expanded(
            flex: _isSearchVisible ? 3 : 1,
            child: _buildSearchWidget(), // Extracted search widget
          ),
        ],
      ),
    );
  }

  /// Builds the animated search widget (either field or icon)
  Widget _buildSearchWidget() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1.0, 0.0), // Slide from right
            end: Offset.zero,
          ).animate(animation),
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      child: _isSearchVisible ? _buildSearchField() : _buildSearchIcon(),
    );
  }

  /// Builds the search text field with decoration
  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          border: InputBorder.none,
          hintText: "Search Recipes",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
          prefixIcon: Icon(Icons.search, color: Colors.black),
          suffixIcon: IconButton(
            icon: Icon(Icons.close, color: Colors.grey[600]),
            onPressed: () => setState(() => _isSearchVisible = false),
          ),
        ),
      ),
    );
  }

  /// Builds the search icon button
  Widget _buildSearchIcon() {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        key: ValueKey('search_icon'),
        icon: Icon(Icons.search, color: Colors.black, size: 28),
        onPressed: () => setState(() => _isSearchVisible = true),
      ),
    );
  }

  /// Builds the main body content
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          _buildSectionTitle("Categories"), // Reusable section title
          SizedBox(height: 20),
          _buildCategoriesList(), // Extracted categories list
          SizedBox(height: 20),
          _buildSectionTitle("Recipes"), // Reusable section title
          SizedBox(height: 15),
          _buildRecipesList(), // Extracted recipes list
        ],
      ),
    );
  }

  /// Builds a section title with consistent styling
  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
        color: Color(0xff4E342E), // Brown color
      ),
    );
  }

  /// Builds the horizontal categories list
  Widget _buildCategoriesList() {
    return FutureBuilder(
      future: _recipesFuture,
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text("Something went wrong ${snap.error}"));
        }
        if (snap.hasData) {
          // Get unique meal types using Set for better performance
          final uniqMeal = <String>{};
          for (var recipe in snap.data!.recipes) {
            uniqMeal.addAll(recipe.mealType);
          }

          return SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: uniqMeal.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Chip(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFFFFE0B2)),
                    ),
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 1,
                    ),
                    label: Text(
                      uniqMeal.elementAt(index),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return SizedBox.shrink(); // Better than empty Container
      },
    );
  }

  /// Builds the vertical recipes list
  Widget _buildRecipesList() {
    return FutureBuilder(
      future: _recipesFuture,
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text("Something went wrong ${snap.error}"));
        }
        if (snap.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snap.data!.recipes.length,
              itemBuilder: (_, index) {
                final recipe = snap.data!.recipes[index]; // Cache the recipe
                return _buildRecipeCard(recipe); // Extracted recipe card
              },
            ),
          );
        }
        return SizedBox.shrink(); // Better than empty Container
      },
    );
  }

  /// Builds an individual recipe card
  Widget _buildRecipeCard(RecipeModel recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/RecipeDetails", arguments: {
          recipe: recipe,
        });
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                recipe.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder:
                    (context, error, stackTrace) =>
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image),
                    ),
              ),
            ),

            SizedBox(width: 12),

            // Recipe details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _buildRecipeDetail(
                    "Prep Time",
                    "${recipe.prepTimeMinutes} min",
                  ),
                  _buildRecipeDetail(
                    "Cook Time",
                    "${recipe.cookTimeMinutes} min",
                  ),
                  _buildRecipeDetail(
                      "Calories", "${recipe.caloriesPerServing}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a consistent recipe detail row
  Widget _buildRecipeDetail(String label, String value) {
    return Text(
      "$label: $value",
      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
    );
  }
}
