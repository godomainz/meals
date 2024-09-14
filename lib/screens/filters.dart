import 'package:flutter/material.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/filter_switch_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(flitersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FilterSwitchTile(
            currentValue: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
          ),
          FilterSwitchTile(
            currentValue: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
          ),
          FilterSwitchTile(
            currentValue: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: 'Vegetarian-free',
            subtitle: 'Only include vegetarian-free meals.',
          ),
          FilterSwitchTile(
            currentValue: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(flitersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: 'Vegan-free',
            subtitle: 'Only include vegan-free meals.',
          ),
        ],
      ),
    );
  }
}
