import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/data/db_utils.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Meal> _favoriteMeals = [];
  List<Meal> loadedMeals = [];
  String tableName = 'favorite_meals';
  String columnId = 'id';
  int _selectedPageIndex = 0;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) async {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      await removeFavourite(meal);
      loadedMeals = await getFavoriteMealsFromDB();
      setState(() {
        // _favoriteMeals.remove(meal);
        _favoriteMeals = loadedMeals;
      });
      _showInfoMessage('Meal is no longer a favourite');
    } else {
      await addFavouriteToDB(meal);
      loadedMeals = await getFavoriteMealsFromDB();
      setState(() {
        // _favoriteMeals.add(meal);
        _favoriteMeals = loadedMeals;
      });
      _showInfoMessage('Marked as a favourite');
    }
    loadedMeals = [];
  }

  void _selectPage(int index) async {
    loadedMeals = await getFavoriteMealsFromDB();
    setState(() {
      _selectedPageIndex = index;
      _favoriteMeals = loadedMeals;
    });
    loadedMeals = [];
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => const FiltersScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your Favorites';
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
