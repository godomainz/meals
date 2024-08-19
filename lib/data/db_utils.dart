import 'package:meals/data/database_helper.dart';
import 'package:meals/models/meal.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase() {
  final dbHelper = DatabaseHelper();
  return dbHelper.database;
}

Future<List<Meal>> getFavoriteMealsFromDB() async {
  Database db = await getDataBase();

  // Query to get all meals from favorite_meals table
  List<Map<String, dynamic>> maps = await db.query('favorite_meals');

  // Convert List<Map<String, dynamic>> to List<Meal>
  List<Meal> favoriteMeals = List.generate(maps.length, (i) {
    return Meal(
      id: maps[i]['id'],
      categories: (maps[i]['categories'] as String)
          .split(','), // Convert back to List<String>
      title: maps[i]['title'],
      imageUrl: maps[i]['imageUrl'],
      ingredients: (maps[i]['ingredients'] as String)
          .split(','), // Convert back to List<String>
      steps: (maps[i]['steps'] as String)
          .split(','), // Convert back to List<String>
      duration: maps[i]['duration'],
      complexity: Complexity.values[maps[i]['complexity']],
      affordability: Affordability.values[maps[i]['complexity']],
      isGlutenFree: maps[i]['isGlutenFree'] == 1,
      isLactoseFree: maps[i]['isLactoseFree'] == 1,
      isVegan: maps[i]['isVegan'] == 1,
      isVegetarian: maps[i]['isVegetarian'] == 1,
    );
  });

  return favoriteMeals;
}

Future<void> addFavouriteToDB(Meal meal) async {
  Database db = await getDataBase();
  Map<String, dynamic> mealMap = {
    'id': meal.id,
    'categories':
        meal.categories.join(','), // Store list as a comma-separated string
    'title': meal.title,
    'imageUrl': meal.imageUrl,
    'ingredients':
        meal.ingredients.join(','), // Store list as a comma-separated string
    'steps': meal.steps.join(','), // Store list as a comma-separated string
    'duration': meal.duration,
    'complexity': meal.complexity.index,
    'affordability': meal.affordability.index,
    'isGlutenFree': meal.isGlutenFree ? 1 : 0, // Store bool as an integer
    'isLactoseFree': meal.isLactoseFree ? 1 : 0, // Store bool as an integer
    'isVegan': meal.isVegan ? 1 : 0, // Store bool as an integer
    'isVegetarian': meal.isVegetarian ? 1 : 0, // Store bool as an integer
  };

  await db.insert('favorite_meals', mealMap);
}

Future<void> removeFavourite(Meal meal) async {
  Database db = await getDataBase();

  // Delete the meal from the favorite_meals table using the meal's id
  await db.delete(
    'favorite_meals',
    where: 'id = ?',
    whereArgs: [meal.id],
  );
}
