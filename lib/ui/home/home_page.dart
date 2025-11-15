import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/core/theme/app_sizes.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/home/bloc/home_bloc.dart';
import 'package:top_quotes/ui/login/bloc/login_bloc.dart';
import 'package:top_quotes/ui/login/login_page.dart';
import '../../core/utils/scaffold_messenger/scaffold_messenger.dart';
import '../quote_detail/quote_detail_page.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/quote_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fabAnimationController;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset > 300 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
        _fabAnimationController.forward();
      } else if (_scrollController.offset <= 300 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
        _fabAnimationController.reverse();
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueishGrey.withValues(alpha: 0.1),
      extendBodyBehindAppBar: false,
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
                  Icons.format_quote,
                  color: Colors.white,
                  size: 28,
                ),
                gapW8,
                Text(
                  'Top Quotes',
                  style: AppTextStyles.subtitle.copyWith(
                    fontFamily: AppFonts.aboreto,
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            leading: Tooltip(
              message: 'Logout',
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.square_arrow_left_fill,
                    color: Colors.white,
                  ),
                  iconSize: 22,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            actions: [
              Tooltip(
                message: 'Refresh',
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                    iconSize: 22,
                    onPressed: () {
                      context.read<HomeBloc>().add(FetchAllQuotesEvent(page: 1));
                    },
                  ),
                ),
              ),
              gapW8,
            ],
          ),
        ),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            CustomScaffoldMessenger.showError(
              error: state.errorMessage.toString(),
            );
            context.read<HomeBloc>().add(ClearHomeErrorEvent());
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // Add scroll listener for pagination
            if (_scrollController.hasClients) {
              _scrollController.addListener(() {
                if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent) {
                  if (!state.isLoading) {
                    context.read<HomeBloc>().add(
                      FetchAllQuotesEvent(page: state.page + 1),
                    );
                  }
                }
              });
            }

            // Loading state
            if (state.isLoading && state.quotes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KProgressIndicator(),
                    gapH16,
                    Text(
                      'Loading inspiring quotes...',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Empty state
            if (state.quotes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_quote_outlined,
                      size: 80,
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                    gapH16,
                    Text(
                      'No quotes available',
                      style: AppTextStyles.subtitle.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH8,
                    Text(
                      'Pull down to refresh',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.chineseSilver,
                      ),
                    ),
                    gapH24,
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<HomeBloc>().add(FetchAllQuotesEvent(page: 1));
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Quotes list with pull-to-refresh
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: Colors.white,
              onRefresh: () async {
                context.read<HomeBloc>().add(FetchAllQuotesEvent(page: 1));
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: size12),
                itemCount: state.quotes.length + (state.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.quotes.length) {
                    return AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 300 + (index * 50)),
                      child: QuoteWidget(
                        quote: state.quotes[index],
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
                      ),
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
                              'Loading more quotes...',
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
          },
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimationController,
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          tooltip: 'Scroll to top',
          child: const Icon(Icons.arrow_upward_rounded),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: AppColors.primary,
              ),
              gapW12,
              const Text('Logout'),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.chineseSilver,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<LoginBloc>().add(LogoutEvent());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
