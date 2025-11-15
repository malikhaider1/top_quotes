import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/core/theme/app_sizes.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/search/bloc/search_bloc.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';

import '../../core/utils/scaffold_messenger/scaffold_messenger.dart';
import '../quote_detail/quote_detail_page.dart';
import '../widgets/progress_indicator_widget.dart';

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
      backgroundColor: AppColors.blueishGrey.withValues(alpha: 0.1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primaryLight,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                gapW8,
                Text(
                  'Search Quotes',
                  style: AppTextStyles.subtitle.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            CustomScaffoldMessenger.showError(
              error: state.errorMessage.toString(),
            );
            context.read<SearchBloc>().add(ClearSearchErrorEvent());
          }
        },
        builder: (context, state) => Column(
          children: [
            // Search Field Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      context.read<SearchBloc>().add(
                        SearchQuotesEvent(
                          query: _searchController.text,
                          page: 1,
                          type: _tabController.index == 0
                              ? ''
                              : _tabController.index == 1
                                  ? 'author'
                                  : 'tag',
                        ),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for quotes, authors, or tags...',
                    hintStyle: TextStyle(
                      color: AppColors.chineseSilver,
                      fontSize: 15,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear_rounded,
                              color: AppColors.chineseSilver,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.raisinBlack,
                  ),
                  onChanged: (value) => setState(() {}),
                ),
              ),
            ),

            // Tab Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.chineseSilver,
                labelStyle: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                unselectedLabelStyle: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.format_quote_rounded, size: 20),
                    text: 'Quotes',
                  ),
                  Tab(
                    icon: Icon(Icons.person_outline_rounded, size: 20),
                    text: 'Authors',
                  ),
                  Tab(
                    icon: Icon(Icons.tag_rounded, size: 20),
                    text: 'Tags',
                  ),
                ],
              ),
            ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildQuotesTab(state),
                  _buildAuthorQuotesTab(state),
                  _buildTagQuotesTab(state),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotesTab(SearchState state) {
    if (state.isLoading && state.quotes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KProgressIndicator(),
            gapH16,
            Text(
              'Searching quotes...',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (state.quotes.isEmpty && _searchController.text.isNotEmpty) {
      return _buildEmptyState(
        icon: Icons.search_off_rounded,
        title: 'No quotes found',
        message: 'Try searching with different keywords',
      );
    }

    if (state.quotes.isEmpty) {
      return _buildEmptyState(
        icon: Icons.format_quote_outlined,
        title: 'Start searching',
        message: 'Enter keywords to find inspiring quotes',
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        if (_searchController.text.isNotEmpty) {
          context.read<SearchBloc>().add(
            SearchQuotesEvent(
              query: _searchController.text,
              page: 1,
              type: '',
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500));
        }
      },
      child: ListView.builder(
        controller: _scrollControllerOnlyQuotes,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: size12),
        itemCount: state.quotes.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < state.quotes.length) {
            return QuoteWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoteDetailPage(
                      quoteId: state.quotes[index].id,
                    ),
                  ),
                );
              },
              quote: state.quotes[index],
              style: QuoteCardStyle.surface,
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(size16),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    gapH12,
                    Text(
                      'Loading more...',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.chineseSilver,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildAuthorQuotesTab(SearchState state) {
    if (state.isLoading && state.authorQuotes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KProgressIndicator(),
            gapH16,
            Text(
              'Searching by author...',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (state.authorQuotes.isEmpty && _searchController.text.isNotEmpty) {
      return _buildEmptyState(
        icon: Icons.person_search_rounded,
        title: 'No authors found',
        message: 'Try searching with different author names',
      );
    }

    if (state.authorQuotes.isEmpty) {
      return _buildEmptyState(
        icon: Icons.person_outline_rounded,
        title: 'Search by author',
        message: 'Enter an author name to find their quotes',
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        if (_searchController.text.isNotEmpty) {
          context.read<SearchBloc>().add(
            SearchQuotesEvent(
              query: _searchController.text,
              page: 1,
              type: 'author',
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500));
        }
      },
      child: ListView.builder(
        controller: _scrollControllerOnlyAuthorQuotes,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: size12),
        itemCount: state.authorQuotes.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < state.authorQuotes.length) {
            return QuoteWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoteDetailPage(
                      quoteId: state.authorQuotes[index].id,
                    ),
                  ),
                );
              },
              quote: state.authorQuotes[index],
              style: QuoteCardStyle.surface,
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(size16),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    gapH12,
                    Text(
                      'Loading more...',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.chineseSilver,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTagQuotesTab(SearchState state) {
    if (state.isLoading && state.tagQuotes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KProgressIndicator(),
            gapH16,
            Text(
              'Searching by tag...',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (state.tagQuotes.isEmpty && _searchController.text.isNotEmpty) {
      return _buildEmptyState(
        icon: Icons.label_off_rounded,
        title: 'No tags found',
        message: 'Try searching with different tags',
      );
    }

    if (state.tagQuotes.isEmpty) {
      return _buildEmptyState(
        icon: Icons.tag_rounded,
        title: 'Search by tag',
        message: 'Enter a tag to find related quotes',
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        if (_searchController.text.isNotEmpty) {
          context.read<SearchBloc>().add(
            SearchQuotesEvent(
              query: _searchController.text,
              page: 1,
              type: 'tag',
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500));
        }
      },
      child: ListView.builder(
        controller: _scrollControllerOnlyTagQuotes,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: size12),
        itemCount: state.tagQuotes.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < state.tagQuotes.length) {
            return QuoteWidget(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoteDetailPage(
                      quoteId: state.tagQuotes[index].id,
                    ),
                  ),
                );
              },
              quote: state.tagQuotes[index],
              style: QuoteCardStyle.surface,
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(size16),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    gapH12,
                    Text(
                      'Loading more...',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.chineseSilver,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          gapH16,
          Text(
            title,
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          gapH8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.chineseSilver,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
