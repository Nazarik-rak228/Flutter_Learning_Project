import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Detail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CourseDetailScreen(),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  const Expanded(
                    child: Text(
                      '3D Design Basic',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Картинка
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0), Color(0xFF7986CB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF3949AB).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -20,
                            top: -20,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                            ),
                          ),
                          Positioned(
                            left: -30,
                            bottom: -40,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), shape: BoxShape.circle),
                            ),
                          ),
                          const Center(child: Icon(Icons.view_in_ar, size: 80, color: Colors.white70)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),


                    Row(
                      children: [
                        _buildStatChip(icon: Icons.people, text: '4.569', color: const Color(0xFF5C6BC0)),
                        const SizedBox(width: 10),
                        _buildStatChip(icon: Icons.star_rounded, text: '4.9', color: const Color(0xFFFFA726)),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EAF6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Best Seller', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF5C6BC0))),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text('3D Design Basic', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 10),
                    Text(
                      'In this course you will learn how to build a space to a 3-dimensional product. There are 24 premium learning videos for you.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('24 Lessons (20 hours)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See all', style: TextStyle(color: Color(0xFF5C6BC0), fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),


                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8EAF6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.play_circle_fill, color: Color(0xFF5C6BC0), size: 28),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Introduction to 3D', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                SizedBox(height: 2),
                                Text('20 mins', style: TextStyle(fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(color: Color(0xFF5C6BC0), shape: BoxShape.circle),
                            child: const Icon(Icons.check, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5C6BC0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('Enroll - \$24.99', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip({required IconData icon, required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
