import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Session Detail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SessionDetailScreen(),
    );
  }
}

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Верхняя иллюстрация
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                color: const Color(0xFFFFE082),
                child: Stack(
                  children: [
                    Positioned(
                      top: 40,
                      left: 30,
                      child: Icon(Icons.cloud, color: Colors.white.withOpacity(0.4), size: 40),
                    ),
                    Positioned(
                      top: 60,
                      right: 50,
                      child: Icon(Icons.cloud, color: Colors.white.withOpacity(0.3), size: 30),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person, size: 40, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 180,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8D6E63),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 160,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6D4C41),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Нижняя часть
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Peter Mach',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500], fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Mind Deep Relax',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Join the Community as we prepare over 33 days to relax and feel joy with the mind and happines session across the World.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
                    ),
                    const SizedBox(height: 20),

                    // Кнопка Play
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow_rounded, size: 28),
                        label: const Text(
                          'Play Next Session',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFA5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Список сессий
                    Expanded(
                      child: ListView(
                        children: [
                          _buildSessionItem(color: const Color(0xFF42A5F5), title: 'Sweet Memories', subtitle: 'December 29 Pre-Launch'),
                          const SizedBox(height: 12),
                          _buildSessionItem(color: const Color(0xFF26A69A), title: 'A Day Dream', subtitle: 'December 29 Pre-Launch'),
                          const SizedBox(height: 12),
                          _buildSessionItem(color: const Color(0xFFFFA726), title: 'Mind Explore', subtitle: 'December 29 Pre-Launch'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionItem({required Color color, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              ],
            ),
          ),
          Icon(Icons.more_horiz, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
