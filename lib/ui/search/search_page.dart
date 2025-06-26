import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_sizes.dart';
import 'package:top_quotes/ui/search/bloc/search_bloc.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';
import 'package:top_quotes/ui/widgets/text_form_field_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollControllerOnlyQuotes = ScrollController();
  final ScrollController _scrollControllerOnlyAuthorQuotes = ScrollController();
  final ScrollController _scrollControllerOnlyTagQuotes = ScrollController();
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
    _scrollControllerOnlyQuotes.dispose();
    _scrollControllerOnlyAuthorQuotes.dispose();
    _scrollControllerOnlyTagQuotes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size64, left: size12, right: size12),
        child: Column(
          children: [
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return KTextFormField(
                  labelText: 'Search',
                  controller: _searchController,
                  onFieldSubmitted: (value) {
                    // Trigger search when the user submits the search query
                    context.read<SearchBloc>().add(
                      SearchQuotesEvent(
                        query: _searchController.text,
                        page: 1, // You can adjust the page number as needed
                        type:
                            _tabController.index == 0
                                ? ''
                                : _tabController.index == 1
                                ? 'author'
                                : 'tag', // Pass the user token if needed
                      ),
                    );
                    return null;
                  },
                  prefixIcon: const Icon(Icons.search),
                );
              },
            ),
            gapH16,
            TabBar(
              // Common TabBar properties you might want to set:
              controller: _tabController,
              labelColor:
                  Theme.of(context).primaryColor, // Example: Set label color
              unselectedLabelColor:
                  Colors.grey, // Example: Set unselected label color
              indicatorColor:
                  Theme.of(
                    context,
                  ).primaryColor, // Example: Set indicator color
              tabs: const [
                Tab(text: 'Quotes'),
                Tab(text: 'Authors'),
                Tab(text: 'Tags'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      _scrollControllerOnlyQuotes.addListener(() {
                        if (_scrollControllerOnlyQuotes.position.pixels ==
                            _scrollControllerOnlyQuotes
                                .position
                                .maxScrollExtent) {
                          // Load more quotes when reaching the end of the list
                          context.read<SearchBloc>().add(
                            SearchQuotesEvent(
                              query: _searchController.text,
                              page: state.page + 1, // Increment page number
                              type: '', // Pass the user token if needed
                            ),
                          );
                        }
                      });
                      return state.isLoading && state.quotes == []
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            controller: _scrollControllerOnlyQuotes,
                            itemCount:
                                state.quotes.length +
                                (state.isLoading
                                    ? 1
                                    : 0), // Replace with actual search results count for Quotes
                            itemBuilder: (context, index) {
                              return index < state.quotes.length
                                  ? QuoteWidget(quote: state.quotes[index])
                                  : Padding(
                                    padding: EdgeInsets.all(size12),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                            },
                          );
                    },
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      _scrollControllerOnlyAuthorQuotes.addListener(() {
                        if (_scrollControllerOnlyAuthorQuotes.position.pixels ==
                            _scrollControllerOnlyAuthorQuotes
                                .position
                                .maxScrollExtent) {
                          // Load more quotes when reaching the end of the list
                          context.read<SearchBloc>().add(
                            SearchQuotesEvent(
                              query: _searchController.text,
                              page: state.page + 1, // Increment page number
                              type: 'author', // Pass the user token if needed
                            ),
                          );
                        }
                      });
                      return state.isLoading && state.authorQuotes == []
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            controller: _scrollControllerOnlyAuthorQuotes,
                            itemCount:
                                state.authorQuotes.length +
                                (state.isLoading ? 1 : 0), // Replace with actual search results count for Authors
                            itemBuilder: (context, index) {
                              return index < state.authorQuotes.length
                                  ? QuoteWidget(
                                    quote: state.authorQuotes[index],
                                  )
                                  : Padding(
                                    padding: EdgeInsets.all(size12),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                            },
                          );
                    },
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      _scrollControllerOnlyTagQuotes.addListener(() {
                        if (_scrollControllerOnlyTagQuotes.position.pixels ==
                            _scrollControllerOnlyTagQuotes
                                .position
                                .maxScrollExtent) {
                          // Load more quotes when reaching the end of the list
                          context.read<SearchBloc>().add(
                            SearchQuotesEvent(
                              query: _searchController.text,
                              page: state.page + 1, // Increment page number
                              type: 'tag', // Pass the user token if needed
                            ),
                          );
                        }
                      });
                      return state.isLoading && state.tagQuotes == []
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        controller: _scrollControllerOnlyTagQuotes,
                            itemCount:
                                state.tagQuotes.length +
                                (state.isLoading ? 1 : 0), // Replace with actual search results count for Authors
                            itemBuilder: (context, index) {
                              return index < state.tagQuotes.length
                                  ? QuoteWidget(quote: state.tagQuotes[index])
                                  : Padding(
                                    padding: EdgeInsets.all(size12),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                            },
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
