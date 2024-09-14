import 'package:flutter/material.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/filter_switch_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  final Map<Filter, bool> currentFilters;

  const FiltersScreen({super.key, required this.currentFilters});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegitarianFreeFilterSet = false;
  var _veganFreeFilterSet = false;
  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegitarianFreeFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFreeFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegitarianFreeFilterSet,
            Filter.vegan: _veganFreeFilterSet,
          });
        },
        child: Column(
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
      ),
    );
  }
}
