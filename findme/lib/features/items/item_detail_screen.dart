import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/item_model.dart';
import '../../widgets/primary_button.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item? item;

  const ItemDetailScreen({super.key, this.item});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late Item _item;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _item =
        widget.item ??
        Item(
          id: '1',
          title: 'Blue Backpack',
          description:
              'Lost a blue backpack with college logo near the library entrance. Contains textbooks, laptop, and personal items. Very important to me.',
          category: 'Bag/Backpack',
          type: 'Lost',
          location: 'Library',
          contactName: 'Jane Smith',
          contactEmail: 'jane@college.edu',
          contactPhone: '+1234567890',
          datePosted: DateTime.now().subtract(const Duration(days: 2)),
          dateLostOrFound: DateTime.now().subtract(const Duration(days: 3)),
          userId: '2',
        );
  }

  void _handleContact() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactRow('Name:', _item.contactName),
            const SizedBox(height: 12),
            _buildContactRow('Email:', _item.contactEmail),
            const SizedBox(height: 12),
            _buildContactRow('Phone:', _item.contactPhone),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _launchEmail(_item.contactEmail);
              Navigator.pop(context);
            },
            child: const Text('Send Email'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _launchEmail(String email) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening email to $email'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleSave() {
    setState(() => _isSaved = !_isSaved);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Item saved!' : 'Item removed from saved'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Item Details'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: AppColors.onPrimary,
            ),
            onPressed: _handleSave,
            tooltip: 'Save item',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Container(
              width: double.infinity,
              height: 250,
              color: AppColors.surfaceVariant.withAlpha((0.5 * 255).round()),
              child: const Icon(
                Icons.image_not_supported,
                size: 64,
                color: AppColors.onSurfaceVariant,
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Title and Type Badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _item.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onBackground,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Posted ${_formatDate(_item.datePosted)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _item.type == 'Lost'
                              ? AppColors.error.withAlpha((0.1 * 255).round())
                              : AppColors.success.withAlpha(
                                  (0.1 * 255).round(),
                                ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _item.type == 'Lost'
                                ? AppColors.error
                                : AppColors.success,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _item.type,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _item.type == 'Lost'
                                ? AppColors.error
                                : AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Item Details Cards
                  _buildDetailCard(
                    icon: Icons.category,
                    label: 'Category',
                    value: _item.category,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailCard(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: _item.location,
                  ),
                  const SizedBox(height: 12),
                  if (_item.dateLostOrFound != null)
                    _buildDetailCard(
                      icon: Icons.calendar_today,
                      label: 'Date ${_item.type == 'Lost' ? 'Lost' : 'Found'}',
                      value: _formatDate(_item.dateLostOrFound!),
                    ),
                  if (_item.dateLostOrFound != null) const SizedBox(height: 24),

                  // Description Section
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant.withAlpha(
                        (0.3 * 255).round(),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.outline.withAlpha((0.3 * 255).round()),
                      ),
                    ),
                    child: Text(
                      _item.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.onBackground,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Contact Section
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onBackground,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withAlpha(
                        (0.2 * 255).round(),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withAlpha((0.3 * 255).round()),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContactInfo(
                          icon: Icons.person,
                          label: 'Name',
                          value: _item.contactName,
                        ),
                        const SizedBox(height: 12),
                        _buildContactInfo(
                          icon: Icons.email,
                          label: 'Email',
                          value: _item.contactEmail,
                        ),
                        const SizedBox(height: 12),
                        _buildContactInfo(
                          icon: Icons.phone,
                          label: 'Phone',
                          value: _item.contactPhone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  PrimaryButton(
                    text: 'Contact Item Poster',
                    onPressed: _handleContact,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('Go Back'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.outline.withAlpha((0.3 * 255).round()),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.onBackground,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.onBackground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
