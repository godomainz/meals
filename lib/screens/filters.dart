import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_switch_tile.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegitarianFreeFilterSet = false;
  var _veganFreeFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FilterSwitchTile(
            currentValue: _glutenFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            },
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
          ),
          FilterSwitchTile(
            currentValue: _lactoseFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _lactoseFreeFilterSet = isChecked;
              });
            },
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
          ),
          FilterSwitchTile(
            currentValue: _vegitarianFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _vegitarianFreeFilterSet = isChecked;
              });
            },
            title: 'Vegetarian-free',
            subtitle: 'Only include vegetarian-free meals.',
          ),
          FilterSwitchTile(
            currentValue: _veganFreeFilterSet,
            onChanged: (isChecked) {
              setState(() {
                _veganFreeFilterSet = isChecked;
              });
            },
            title: 'Vegan-free',
            subtitle: 'Only include vegan-free meals.',
          ),
        ],
      ),
    );
  }
}
