import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes_via_api/Models/models.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    RecipeModel recipe = args["recipe"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(recipe.name, overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe Image
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        height: 250,
                        width: 350,
                        recipe.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 250,
                            width: 350,
                            color: Colors.grey[200],
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      )),
                ),
                SizedBox(height: 11),
                // Row to display various recipe details like rating, difficulty,
                // cuisine, review count, and servings
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Row to display recipe rating
                      Row(
                        children: [
                          // Star icon for rating
                          Icon(Icons.star, size: 24, color: Colors.amber),
                          SizedBox(width: 5),
                          // Recipe rating text
                          Text("${recipe.rating}",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      // Row to display recipe difficulty
                      Row(
                        // Network icon for difficulty
                        children: [
                          Icon(Icons.network_check, size: 24,
                              color: Colors.blueAccent),
                          SizedBox(width: 5),
                          // Recipe difficulty text
                          Text(recipe.difficulty,
                              style: GoogleFonts.poppins(
                                // Text style
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      ),
                      // Row to display recipe cuisine
                      Row(
                        // Public icon for cuisine
                        children: [
                          Icon(Icons.public, size: 24, color: Colors.green),
                          SizedBox(width: 5),
                          // Recipe cuisine text
                          Text(recipe.cuisine,
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  // Text style
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ],
                      ),
                      // Row to display recipe review count
                      Row(
                        children: [
                          // Eye icon for review count
                          Icon(Icons.remove_red_eye, size: 24,
                              color: Colors.redAccent),
                          SizedBox(width: 5),
                          // Recipe review count text
                          Text("${recipe.reviewCount}",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      // Row to display recipe servings
                      Row(
                        // Restaurant icon for servings
                        children: [
                          Icon(Icons.restaurant, size: 24,
                              color: Colors.orangeAccent),
                          SizedBox(width: 5),
                          // Recipe servings text
                          Text("${recipe.servings}",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ]
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                SizedBox(height: 10),
                // Recipe Ingredients
                Text("INGREDIENTS",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                // Ingredients list - Display ingredients
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recipe.ingredients.length,
                  itemBuilder: (context, index) {
                    return Text(
                      "• ${recipe.ingredients[index]}",
                      style: GoogleFonts.lato(fontSize: 16),
                    );
                  },
                ),
                SizedBox(height: 5.5),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                SizedBox(height: 5.5),
                // Recipe Instructions heading
                Text("INSTRUCTIONS",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w500)),
                // Instructions list - Display instructions
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipe.instructions.length,
                    itemBuilder: (_, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text("• ${recipe.instructions[index]}",
                              style: GoogleFonts.lato(fontSize: 16)),
                        ],
                      );
                    }
                )
              ]),
        ),
      ),
    );
  }
}
