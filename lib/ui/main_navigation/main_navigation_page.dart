import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/favorite/bloc/favorite_bloc.dart';
import 'package:top_quotes/ui/favorite/favorite_page.dart';
import 'package:top_quotes/ui/home/home_page.dart';
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
      Center(child: Text('Profile Page')),
    ];
    final favorites = context.read<FavoriteBloc>().state.quotes.quotes;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,// Use fixed type for more than 3 items
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.format_quote), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.find_replace_sharp), label: 'Search'),
          BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.favorite_outline_sharp),
                  Positioned(
                    right: -7,
                    top: -3,
                    child: Container(// Width of the badge
                      //padding: EdgeInsets.all(2), // Padding around the badge
                      decoration: BoxDecoration(
                        color: AppColors.lightCrimson,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 20, // Minimum width of the badge
                        minHeight: 17,
                      ),
                      child: Text(
                       favorites.length>9?'9+':favorites.length.toString(), // Badge count
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontSize: 10.5,),
                          textAlign: TextAlign.center, // Center the text in the badge
                      ),
                    ),
                  ),
                ],
              ), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        currentIndex: _selectedIndex, // Display the current selected index
        onTap: (index) {
          // 2. Update State on Tab Tap
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ); // 3. Animate to the selected page
        },
      ),
      body: PageView.builder(
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
}