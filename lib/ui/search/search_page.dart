import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_sizes.dart';
import 'package:top_quotes/ui/search/bloc/search_bloc.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';
import 'package:top_quotes/ui/widgets/text_form_field_widget.dart';

import '../../core/utils/scaffold_messenger/scaffold_messenger.dart';
import '../quote_detail/quote_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollControllerOnlyQuotes = ScrollController();
  final ScrollController _scrollControllerOnlyAuthorQuotes = ScrollController();
  final ScrollController _scrollControllerOnlyTagQuotes = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    // Add scroll listeners for pagination
    _scrollControllerOnlyQuotes.addListener(_onQuotesScroll);
    _scrollControllerOnlyAuthorQuotes.addListener(_onAuthorQuotesScroll);
    _scrollControllerOnlyTagQuotes.addListener(_onTagQuotesScroll);
  }

  void _onQuotesScroll() {
    if (_scrollControllerOnlyQuotes.position.pixels ==
        _scrollControllerOnlyQuotes.position.maxScrollExtent) {
      final state = context.read<SearchBloc>().state;
      if (!state.isLoading) {
        context.read<SearchBloc>().add(
          SearchQuotesEvent(
            query: _searchController.text,
            page: state.page + 1,
            type: '',
          ),
        );
      }
    }
  }

  void _onAuthorQuotesScroll() {
    if (_scrollControllerOnlyAuthorQuotes.position.pixels ==
        _scrollControllerOnlyAuthorQuotes.position.maxScrollExtent) {
      final state = context.read<SearchBloc>().state;
      if (!state.isLoading) {
        context.read<SearchBloc>().add(
          SearchQuotesEvent(
            query: _searchController.text,
            page: state.page + 1,
            type: 'author',
          ),
        );
      }
    }
  }

  void _onTagQuotesScroll() {
    if (_scrollControllerOnlyTagQuotes.position.pixels ==
        _scrollControllerOnlyTagQuotes.position.maxScrollExtent) {
      final state = context.read<SearchBloc>().state;
      if (!state.isLoading) {
        context.read<SearchBloc>().add(
          SearchQuotesEvent(
            query: _searchController.text,
            page: state.page + 1,
            type: 'tag',
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    // Remove scroll listeners
    _scrollControllerOnlyQuotes.removeListener(_onQuotesScroll);
    _scrollControllerOnlyAuthorQuotes.removeListener(_onAuthorQuotesScroll);
    _scrollControllerOnlyTagQuotes.removeListener(_onTagQuotesScroll);
    _scrollControllerOnlyQuotes.dispose();
    _scrollControllerOnlyAuthorQuotes.dispose();
    _scrollControllerOnlyTagQuotes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size64, left: 10, right: 10),
        child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              CustomScaffoldMessenger.showError(error: state.errorMessage.toString());
              context.read<SearchBloc>().add(ClearSearchErrorEvent());
            }
          },
          builder:
              (context, state) => Column(
                children: [
                  KTextFormField(
                    labelText: 'Search',
                    controller: _searchController,
                    onFieldSubmitted: (value) {
                      context.read<SearchBloc>().add(
                        SearchQuotesEvent(
                          query: _searchController.text,
                          page: 1,
                          type:
                              _tabController.index == 0
                                  ? ''
                                  : _tabController.index == 1
                                  ? 'author'
                                  : 'tag',
                        ),
                      );
                      return null;
                    },
                    prefixIcon: const Icon(Icons.search),
                  ),
                  gapH16,
                  TabBar(
                    controller: _tabController,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).primaryColor,
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
                        (state.isLoading && state.quotes.isEmpty)
                            ? CircularProgressIndicator()
                            : ListView.builder(
                              controller: _scrollControllerOnlyQuotes,
                              itemCount:
                                  state.quotes.length +
                                  (state.isLoading ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index < state.quotes.length) {
                                  return QuoteWidget(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => QuoteDetailPage(
                                                quoteId: state.quotes[index].id,
                                              ),
                                        ),
                                      );
                                    },
                                    quote: state.quotes[index],
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),

                        (state.isLoading && state.authorQuotes.isEmpty)
                            ? CircularProgressIndicator()
                            : ListView.builder(
                              controller: _scrollControllerOnlyAuthorQuotes,
                              itemCount:
                                  state.authorQuotes.length +
                                  (state.isLoading ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index < state.authorQuotes.length) {
                                  return QuoteWidget(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => QuoteDetailPage(
                                                // FIXED: Use authorQuotes instead of quotes
                                                quoteId:
                                                    state
                                                        .authorQuotes[index]
                                                        .id,
                                              ),
                                        ),
                                      );
                                    },
                                    quote: state.authorQuotes[index],
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),

                        (state.isLoading && state.tagQuotes.isEmpty)?
                        CircularProgressIndicator():ListView.builder(
                          controller: _scrollControllerOnlyTagQuotes,
                          itemCount:
                          state.tagQuotes.length +
                              (state.isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < state.tagQuotes.length) {
                              return QuoteWidget(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => QuoteDetailPage(
                                        // FIXED: Use tagQuotes instead of quotes
                                        quoteId:
                                        state.tagQuotes[index].id,
                                      ),
                                    ),
                                  );
                                },
                                quote: state.tagQuotes[index],
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(12),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
