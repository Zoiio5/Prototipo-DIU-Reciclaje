import 'package:flutter/material.dart';

class RecyclingCategory {
  final String name;
  final IconData icon;
  final String description;

  RecyclingCategory({
    required this.name,
    required this.icon,
    required this.description,
  });
}

class RecyclingCategoryCard extends StatefulWidget {
  final RecyclingCategory category;
  final bool isDark;

  const RecyclingCategoryCard({
    super.key,
    required this.category,
    required this.isDark,
  });

  @override
  State<RecyclingCategoryCard> createState() => _RecyclingCategoryCardState();
}

class _RecyclingCategoryCardState extends State<RecyclingCategoryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF374151) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withAlpha((0.1 * 255).round()),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Icon(
                      widget.category.icon,
                      color: const Color(0xFF10B981),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.category.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: widget.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: widget.isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                widget.category.description,
                style: TextStyle(
                  color: widget.isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                ),
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  String _searchQuery = '';

  final List<RecyclingCategory> categories = [
    RecyclingCategory(
      name: 'Papel/Cartón',
      icon: Icons.text_snippet,
      description: 'Asegúrate de que esté limpio y plegado para ahorrar espacio.',
    ),
    RecyclingCategory(
      name: 'Plástico',
      icon: Icons.sync_alt,
      description: 'Enjuaga los envases y retira las tapas. Compacta si es posible.',
    ),
    RecyclingCategory(
      name: 'Vidrio',
      icon: Icons.home_outlined,
      description: 'Limpio, sin corchos ni tapas. No depositar bombillas ni espejos.',
    ),
    RecyclingCategory(
      name: 'Metal',
      icon: Icons.shopping_cart,
      description: 'Latas de bebidas y conservas. Límpialas y aplástalas.',
    ),
    RecyclingCategory(
      name: 'Orgánicos',
      icon: Icons.eco,
      description: 'Restos de comida, posos de café y restos de jardín. No incluir aceites.',
    ),
  ];

  List<RecyclingCategory> get filteredCategories {
    if (_searchQuery.isEmpty) return categories;
    return categories
        .where((category) => category.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB),
                border: Border(
                  bottom: BorderSide(color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.menu, color: isDark ? Colors.white : Colors.black), onPressed: () {}),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Guía de Reciclaje', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black)),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (v) => setState(() => _searchQuery = v),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              hintText: 'Buscar categoría',
                              filled: true,
                              fillColor: isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                              prefixIcon: Icon(Icons.search, color: isDark ? Colors.white70 : Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(backgroundColor: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB), child: Icon(Icons.person, color: isDark ? Colors.white : Colors.black)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Progress card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF111827) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha((0.04 * 255).round()), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Row(
                  children: [
                    CircularProgressIndicator(value: 0.6, color: const Color(0xFF10B981), backgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recycling progress', style: TextStyle(fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black)),
                          const SizedBox(height: 6),
                          Text('Has reciclado 60% este mes. Sigue así!', style: TextStyle(color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280))),
                        ],
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('Ver detalles')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Categories list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 5, mainAxisSpacing: 12),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final cat = filteredCategories[index];
                    return RecyclingCategoryCard(category: cat, isDark: isDark);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}