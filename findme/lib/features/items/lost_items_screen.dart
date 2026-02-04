import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/item_model.dart';
import '../../services/api_service.dart';
import '../../widgets/item_card.dart';
import '../../app/routes.dart';

class LostItemsScreen extends StatefulWidget {
  const LostItemsScreen({super.key});

  @override
  State<LostItemsScreen> createState() => _LostItemsScreenState();
}

class _LostItemsScreenState extends State<LostItemsScreen> {
  final _apiService = ApiService();
  late Future<List<Item>> _lostItemsFuture;
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _lostItemsFuture = _apiService.getLostItems();
  }

  List<Item> _filterItems(List<Item> items) {
    return items.where((item) {
      bool matchesSearch =
          _searchQuery.isEmpty ||
          item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesCategory =
          _selectedCategory == null || item.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Lost Items'),
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Item>>(
        future: _lostItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading items',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
            );
          }

          final items = snapshot.data ?? [];
          final filteredItems = _filterItems(items);

          return Column(
            children: [
              // Search and Filter
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Search Bar
                    TextField(
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search lost items...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Category Filter
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip(
                            label: 'All',
                            selected: _selectedCategory == null,
                            onTap: () {
                              setState(() => _selectedCategory = null);
                            },
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            label: 'Electronics',
                            selected: _selectedCategory == 'Electronics',
                            onTap: () {
                              setState(() => _selectedCategory = 'Electronics');
                            },
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            label: 'Books',
                            selected: _selectedCategory == 'Books',
                            onTap: () {
                              setState(() => _selectedCategory = 'Books');
                            },
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            label: 'Accessories',
                            selected: _selectedCategory == 'Accessories',
                            onTap: () {
                              setState(() => _selectedCategory = 'Accessories');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Items List
              if (filteredItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: AppColors.onSurfaceVariant.withAlpha(
                            (0.5 * 255).round(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No items found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Try adjusting your search or filters',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ItemCard(
                        item: item,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.itemDetail,
                            arguments: {'item': item},
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primaryContainer,
      labelStyle: TextStyle(
        color: selected ? AppColors.onPrimaryContainer : AppColors.onBackground,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.outline,
          width: 1,
        ),
      ),
    );
  }
}
