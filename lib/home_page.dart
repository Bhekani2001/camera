import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController _menuAnimationController;

  @override
  void initState() {
    super.initState();
    _menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      isMenuOpen
          ? _menuAnimationController.forward()
          : _menuAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page').animate().fade().slideY(),
        leading: IconButton(
          icon: const Icon(Icons.menu).animate().fade().slideX(),
          onPressed: toggleMenu, // Toggle the menu
        ),
        backgroundColor: Colors.blue, // Set AppBar background color
      ),
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                // Camera Card (Big Card)
                GestureDetector(
                  onTap: () {
                    // Open the camera (placeholder for now)
                    print("Camera Card Clicked");
                  },
                  child: Container(
                    height: 200, // Bigger size for the camera card
                    margin: const EdgeInsets.only(bottom: 16.0), // Space below the card
                    decoration: BoxDecoration(
                      color: Colors.green, // Color for camera card
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Open Camera',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // GridView for folders
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns (more compact)
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 1.0, // Keep it square for folder look
                    ),
                    itemCount: 4, // Number of folders
                    itemBuilder: (context, index) {
                      final folders = [
                        {
                          'title': 'Liked Images',
                          'icon': Icons.favorite,
                          'count': 12,
                          'color': Colors.pink
                        },
                        {
                          'title': 'Recent',
                          'icon': Icons.history,
                          'count': 12,
                          'color': Colors.blue
                        },
                        {
                          'title': 'Favorites',
                          'icon': Icons.star,
                          'count': 15,
                          'color': Colors.yellow
                        },
                        {
                          'title': 'Archives',
                          'icon': Icons.archive,
                          'count': 20,
                          'color': Colors.orange
                        },
                      ];

                      final folder = folders[index];
                      return GestureDetector(
                        onTap: () {
                          // Add navigation or functionality here
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: folder['color'] as Color,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: (folder['color'] as Color).withOpacity(0.5),
                                blurRadius: 4.0,
                                spreadRadius: 1.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  folder['icon'] as IconData,
                                  size: 30.0, // Smaller icon
                                  color: Colors.white,
                                )
                                    .animate()
                                    .fade(delay: (index * 200).ms)
                                    .scale(duration: 400.ms),
                                const SizedBox(height: 8.0),
                                Text(
                                  folder['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                                    .animate()
                                    .fade(delay: (index * 300).ms)
                                    .slideY(duration: 400.ms),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${folder['count']} items',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white70,
                                  ),
                                )
                                    .animate()
                                    .fade(delay: (index * 400).ms)
                                    .slideY(duration: 500.ms),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Animated Drawer Menu
          AnimatedBuilder(
            animation: _menuAnimationController,
            builder: (context, child) {
              double slide = 250.0 * _menuAnimationController.value;
              double scale = 1.0 - (_menuAnimationController.value * 0.2);
              return Stack(
                children: [
                  // The Menu
                  Positioned(
                    left: slide - 250,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 250,
                      color: Colors.red,
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          ListTile(
                            leading: const Icon(Icons.home, color: Colors.white),
                            title: const Text(
                              'Home',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                           ListTile(
                            leading: const Icon(Icons.cloud, color: Colors.white),
                            title: const Text(
                              'Cload Store',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings,
                                color: Colors.white),
                            title: const Text(
                              'Settings',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.share,
                                color: Colors.white),
                            title: const Text(
                              'Share',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Main Content Scale
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (isMenuOpen) toggleMenu();
                      },
                      child: AbsorbPointer(
                        absorbing: isMenuOpen,
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _menuAnimationController.dispose();
    super.dispose();
  }
}
