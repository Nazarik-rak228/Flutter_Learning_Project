import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popular Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const PopularMenuScreen(),
    );
  }
}

class PopularMenuScreen extends StatefulWidget {
  const PopularMenuScreen({super.key});

  @override
  State<PopularMenuScreen> createState() => _PopularMenuScreenState();
}

class _PopularMenuScreenState extends State<PopularMenuScreen> {
  int currentBottomIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Original Salad', 'restaurant': 'Lovy Food', 'price': 8, 'color': const Color(0xFFFFECB3), 'icon': Icons.eco},
    {'name': 'Fresh Salad', 'restaurant': 'Cloudy Resto', 'price': 10, 'color': const Color(0xFFE8F5E9), 'icon': Icons.spa},
    {'name': 'Yummie Ice Cream', 'restaurant': 'Circlo Resto', 'price': 6, 'color': const Color(0xFFFCE4EC), 'icon': Icons.icecream},
    {'name': 'Vegan Special', 'restaurant': 'Haty Food', 'price': 11, 'color': const Color(0xFFE0F2F1), 'icon': Icons.grass},
    {'name': 'Mixed Pasta', 'restaurant': 'Recto Food', 'price': 13, 'color': const Color(0xFFFFF3E0), 'icon': Icons.ramen_dining},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Expanded(
                    child: Text(
                      'Popular Menu',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(width: 42),
                ],
              ),
            ),

            // Поиск
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 22),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
                    ),
                    child: Icon(Icons.tune, color: Colors.grey[600], size: 22),
                  ),
                ],
              ),
            ),

            // Список блюд
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: item['color'] as Color,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(item['icon'] as IconData, color: Colors.black54, size: 30),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
                              const SizedBox(height: 4),
                              Text(item['restaurant'] as String, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                            ],
                          ),
                        ),
                        Text(
                          '\$${item['price']}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE91E63)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Нижняя навигация
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomItem(Icons.home, 'Home', 0),
            _buildBottomItem(Icons.shopping_bag_outlined, '', 1),
            _buildBottomItem(Icons.chat_bubble_outline, '', 2),
            _buildBottomItem(Icons.person_outline, '', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomItem(IconData icon, String label, int index) {
    final bool isSelected = currentBottomIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentBottomIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: isSelected && label.isNotEmpty ? 16 : 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEBEE) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: isSelected ? const Color(0xFFE91E63) : Colors.grey[400]),
            if (isSelected && label.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ],
        ),
      ),
    );
  }
}
