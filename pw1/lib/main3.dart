import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditate Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MeditateHomeScreen(),
    );
  }
}


class MeditateHomeScreen extends StatefulWidget {
  const MeditateHomeScreen({super.key});

  @override
  State<MeditateHomeScreen> createState() => _MeditateHomeScreenState();
}

class _MeditateHomeScreenState extends State<MeditateHomeScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    'All',
    'Bible In a Year',
    'Dailies',
    'Minutes',
    'November'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Шапка
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Meditate',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, size: 26),
                  ),
                ],
              ),
            ),

            // Категории
            SizedBox(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final bool isSelected = selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF00BFA5) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Контент
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildFeaturedCard(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSmallCard(
                            title: 'The Sleep Hour',
                            author: 'Ashina Mukherjee',
                            sessions: '3 Sessions',
                            bgColor: const Color(0xFFFFB74D),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _buildSmallCard(
                            title: 'Easy on the Mission',
                            author: 'Peter Mach',
                            sessions: '5 minutes',
                            bgColor: const Color(0xFFFFCC80),
                            isMoon: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSmallCard(
                            title: 'Relax with Me',
                            author: 'Amanda James',
                            sessions: '3 Sessions',
                            bgColor: const Color(0xFF4FC3F7),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _buildSmallCard(
                            title: 'Sun and Energy',
                            author: 'Micheal Hiu',
                            sessions: '5 minutes',
                            bgColor: const Color(0xFF26A69A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE0B2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 20,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9800),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.wb_sunny, color: Colors.white, size: 40),
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 30,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5C6BC0),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.nightlight_round, color: Colors.white, size: 32),
                    ),
                  ),
                ),
                const Positioned(top: 25, left: 140, child: Icon(Icons.star, color: Colors.amber, size: 14)),
                const Positioned(top: 50, right: 120, child: Icon(Icons.star, color: Colors.amber, size: 10)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'A Song of Moon',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text('Start with the basics', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite_border, size: 16, color: Colors.grey[500]),
                        const SizedBox(width: 6),
                        Text('9 Sessions', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('Start', style: TextStyle(color: Color(0xFF00BFA5), fontWeight: FontWeight.w600)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF00BFA5)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard({
    required String title,
    required String author,
    required String sessions,
    required Color bgColor,
    bool isMoon = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Icon(
                isMoon ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(author, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(sessions, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                      ],
                    ),
                    const Text('Start ›', style: TextStyle(fontSize: 12, color: Color(0xFF00BFA5), fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
