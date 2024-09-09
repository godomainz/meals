import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/db_utils.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]) {
    _loadFavoriteMeals();
  }

  Future<void> _loadFavoriteMeals() async {
    final List<Meal> favoriteMeals = await getFavoriteMealsFromDB();
    state = favoriteMeals; // Set the initial state
  }

  Future<bool> toggleMealFavoriteStatus(Meal meal) async {
    final bool mealIsFavorite = await isMealExist(meal);
    if (mealIsFavorite) {
      await removeFavourite(meal);
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      await addFavouriteToDB(meal);
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
