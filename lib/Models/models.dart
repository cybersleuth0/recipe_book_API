class RecipeModel {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  String difficulty;
  String cuisine;
  int caloriesPerServing;
  List<String> tags;
  int userId;
  String image;
  num rating;
  int reviewCount;
  List<String> mealType;

  RecipeModel({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      prepTimeMinutes: json['prepTimeMinutes'],
      cookTimeMinutes: json['cookTimeMinutes'],
      servings: json['servings'],
      difficulty: json['difficulty'],
      cuisine: json['cuisine'],
      caloriesPerServing: json['caloriesPerServing'],
      tags: List<String>.from(json['tags']),
      userId: json['userId'],
      image: json['image'],
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      mealType: List<String>.from(json['mealType']),
    );
  }
}

class RecipeDataModel {
  List<RecipeModel> recipes;
  int total;
  int skip;
  int limit;

  RecipeDataModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory RecipeDataModel.fromJson(Map<String, dynamic> json) {
    // List<RecipeModel> recipesData =
    //     (json['recipes'] as List)
    //         .map((recipe) => RecipeModel.fromJson(recipe))
    //         .toList();

    List<RecipeModel> recipesData = [];
    for (Map<String, dynamic> recipe in json['recipes']) {
      recipesData.add(RecipeModel.fromJson(recipe));
    }

    return RecipeDataModel(
      recipes: recipesData,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
