import 'package:flutter/material.dart';

class RecyclingGuideApp extends StatelessWidget {
  const RecyclingGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guía de Reciclaje',
      theme: ThemeData(
        primaryColor: const Color(0xFF10B981),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'PublicSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF10B981),
        scaffoldBackgroundColor: const Color(0xFF1F2937),
        fontFamily: 'PublicSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF10B981),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const GuideScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  int _selectedIndex = 1;
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
    if (_searchQuery.isEmpty) {
      return categories;
    }
    return categories
        .where((category) =>
            category.name.toLowerCase().contains(_searchQuery.toLowerCase()))
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
        color: isDark
          ? const Color(0xFF1F2937).withAlpha((0.8 * 255).round())
          : const Color(0xFFF9FAFB).withAlpha((0.8 * 255).round()),
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Text(
                        'Guía de Reciclaje',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF374151) : Colors.white,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                          color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Buscar por tipo de residuo',
                          hintStyle: TextStyle(
                            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Progress Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF374151) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.05 * 255).round()),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Progress Circle
                          SizedBox(
                            width: 64,
                            height: 64,
                            child: Stack(
                              children: [
                                CircularProgressIndicator(
                                  value: 0.75,
                                  strokeWidth: 8,
                                  backgroundColor: const Color(0xFF10B981).withAlpha((0.2 * 255).round()),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF10B981),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    '75%',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF10B981),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tu Progreso',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text(
                                  'Meta semanal: 10kg reciclados',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Ver Detalle',
                              style: TextStyle(
                                color: Color(0xFF10B981),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Categories
                    ...filteredCategories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RecyclingCategoryCard(
                          category: category,
                          isDark: isDark,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F2937).withAlpha((0.8 * 255).round()) : const Color(0xFFF9FAFB).withAlpha((0.8 * 255).round()),
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: const Color(0xFF10B981),
              unselectedItemColor: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Mapa',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book),
                  label: 'Guía',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Alertas',
                ),
              ],
            ),
            Container(
              height: 12,
              color: isDark ? const Color(0xFF374151) : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // _buildNavItem removed because it's not referenced; navigation handled inline.
}

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
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
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

