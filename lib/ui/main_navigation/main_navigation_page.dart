import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/favorite/bloc/favorite_bloc.dart';
import 'package:top_quotes/ui/favorite/favorite_page.dart';
import 'package:top_quotes/ui/home/home_page.dart';
import 'package:top_quotes/ui/quote_of_the_day/quote_of_the_day_page.dart';
import 'package:top_quotes/ui/random_word/random_word_page.dart';
import 'package:top_quotes/ui/search/search_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  // 1. State to Manage Selected Index
  int _selectedIndex = 0;

  // Controller for the PageView
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This widget builds a simple bottom navigation bar with three items.
    final pages = [
      HomePage(),
      SearchPage(),
      FavoritePage(),
      QuoteOfTheDayPage(),
      RandomWordPage(),
     // ProfilePage(),
    ];
    // Removed direct read here to avoid stale badge; we'll rebuild via BlocBuilder below

    return Scaffold(
      bottomNavigationBar: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, favState) {
          final favoritesCount = favState.quotes.quotes.length;
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: BottomNavigationBar(
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.transparent,
                    currentIndex: _selectedIndex,
                    selectedItemColor: AppColors.primary,
                    unselectedItemColor: AppColors.chineseSilver,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedLabelStyle: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.format_quote_outlined),
                        activeIcon: const Icon(Icons.format_quote_rounded),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.search_outlined),
                        activeIcon: const Icon(Icons.search_rounded),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: _buildFavoritesIcon(false, favoritesCount),
                        activeIcon: _buildFavoritesIcon(true, favoritesCount),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(CupertinoIcons.quote_bubble),
                        activeIcon: const Icon(CupertinoIcons.quote_bubble_fill),
                        label: 'QOD',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.casino_outlined),
                        activeIcon: const Icon(Icons.casino_rounded),
                        label: 'Random',
                      ),
                    ],
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                      _pageController.jumpToPage(_selectedIndex);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(), // Disable swipe to change pages
        controller: _pageController, // Assign the controller
        onPageChanged: (index) {
          // 4. Update Selected Tab on Page Swipe
          setState(() {
            _selectedIndex = index;
          });
        },
        itemCount: pages.length, // Important to set itemCount for PageView.builder
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }

  Widget _buildFavoritesIcon(bool active, int count) {
    final baseIcon = active ? Icons.favorite_rounded : Icons.favorite_outline_rounded;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(baseIcon),
        if (count > 0)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryLight.withValues(alpha: 0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : '$count',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}