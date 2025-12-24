import 'package:flutter/material.dart';
import 'package:untitled7/core/routes/routes_app.dart';
import 'package:untitled7/features/cart/presentation/view/cart_page.dart';

import '../../../favorite/presentation/view/favorite_page.dart';
import '../../../products/presentation/view/products_screen.dart';
import '../../presentation/view/favorite_screen.dart';
import '../../presentation/view/order_screen.dart';
import '../../presentation/view/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  final List<Widget> pages = [
    const ProductsScreen(),
    const CartPage(),
    const FavoritesPage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: _buildAnimatedNavBar(),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      title: const Text(
        "HubStyle",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.black, // نفس لون الـ BottomNavigationBar المحدد
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[800],
        ),
        child: IconButton(
          onPressed: () {
            // إضافة وظيفة للزر هنا
          },
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 22,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[800],
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesApp.settings);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 22,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black87,
              Colors.grey[900]!,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_navItems.length, (index) {
          final item = _navItems[index];
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
              setState(() => currentIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 20 : 12,
                vertical: isSelected ? 8 : 6,
              ),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: isSelected
                    ? Border.all(color: Colors.grey[300]!)
                    : null,
              ),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.3 : 1.0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      item['icon'],
                      color: isSelected ? Colors.black : Colors.grey[400],
                      size: 26,
                    ),
                  ),
                  if (isSelected)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          item['label'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Icons.home, "label": "Home"},
    {"icon": Icons.card_travel, "label": "Orders"},
    {"icon": Icons.favorite, "label": "Favorite"},
    {"icon": Icons.person, "label": "Profile"},
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}