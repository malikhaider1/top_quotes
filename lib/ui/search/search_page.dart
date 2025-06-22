import 'package:flutter/material.dart';
import 'package:top_quotes/core/theme/app_sizes.dart';
import 'package:top_quotes/ui/widgets/text_form_field_widget.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size64, left: size16, right: size16),
        child: Column(
          children: [
            KTextFormField(
              labelText: 'Search',
              controller: _searchController,
              prefixIcon: const Icon(Icons.search),
            ),
            gapH16,
            TabBar(
              // Common TabBar properties you might want to set:
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor, // Example: Set label color
              unselectedLabelColor: Colors.grey, // Example: Set unselected label color
              indicatorColor: Theme.of(context).primaryColor, // Example: Set indicator color
              tabs: const [
                Tab(text: 'Quotes'),
                Tab(text: 'Authors'),
                Tab(text: 'Topics'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Content for 'Quotes' tab
                  ListView.builder(
                    itemCount: 10, // Replace with actual search results count for Quotes
                    itemBuilder: (context, index) {
                      // TODO: Replace with your actual Quote item widget
                      return ListTile(
                        title: Text('Quote Result $index'),
                        // Example: onTap: () { /* Navigate to quote details */ },
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 5, // Replace with actual search results count for Authors
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Author Result $index'),
                        // Example: onTap: () { /* Navigate to author details */ },
                      );
                    },
                  ),
                  // Content for 'Topics' tab
                  ListView.builder(
                    itemCount: 7, // Replace with actual search results count for Topics
                    itemBuilder: (context, index) {
                      // TODO: Replace with your actual Topic item widget
                      return ListTile(
                        title: Text('Topic Result $index'),
                        // Example: onTap: () { /* Navigate to topic details */ },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}