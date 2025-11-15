import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/ui/favorite/bloc/favorite_bloc.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../quote_detail/quote_detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<void> _handleRefresh() async {
    context.read<FavoriteBloc>().add(FetchFavoriteQuotesEvent(page: 1));
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueishGrey.withValues(alpha: 0.08),
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
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Favorite Quotes',
              style: AppTextStyles.subtitle.copyWith(
                fontFamily: AppFonts.aboreto,
                color: Colors.white,
                letterSpacing: 0.4,
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  color: Colors.white,
                  onPressed: _handleRefresh,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildContent(state),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(FavoriteState state) {
    final quotes = state.quotes.quotes;
    if (state.isLoading && quotes.isEmpty) {
      return _buildSkeletonList();
    }

    if (state.errorMessage.isNotEmpty && quotes.isEmpty) {
      return _FavoriteStatusCard(
        icon: Icons.error_outline_rounded,
        title: 'Something went wrong',
        message: state.errorMessage,
        primaryLabel: 'Retry',
        onPrimaryTap: _handleRefresh,
      );
    }

    if (quotes.isEmpty) {
      return _FavoriteStatusCard(
        icon: Icons.bookmarks_outlined,
        title: 'No favorites yet',
        message: 'Save the quotes you love and they will live here for easy access.',
        primaryLabel: 'Discover quotes',
        onPrimaryTap: () => Navigator.of(context).maybePop(),
        secondaryLabel: 'Refresh',
        onSecondaryTap: _handleRefresh,
      );
    }

    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColors.primary,
      onRefresh: _handleRefresh,
      child: Skeletonizer(
        enabled: state.isLoading,
        effect: const ShimmerEffect(
          baseColor: Color(0x33FFFFFF),
          highlightColor: Color(0x55FFFFFF),
        ),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: quotes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 6),
          itemBuilder: (context, index) {
            return QuoteWidget(
              padding: const EdgeInsets.symmetric(vertical: 6),
              quote: quotes[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoteDetailPage(
                      quoteId: quotes[index].id,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (_, __) => const Skeletonizer(
        child: QuoteWidgetSkeleton(),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemCount: 4,
    );
  }
}

class _FavoriteStatusCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimaryTap;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryTap;

  const _FavoriteStatusCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimaryTap,
    this.secondaryLabel,
    this.onSecondaryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          // margin:  EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          // padding:  EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 56,
                color: Colors.white.withValues(alpha: 0.85),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: AppTextStyles.title.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onPrimaryTap,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  textStyle: AppTextStyles.subtitle.copyWith(color: Colors.white),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(primaryLabel),
              ),
              if (secondaryLabel != null && onSecondaryTap != null) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: onSecondaryTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  ),
                  child: Text(secondaryLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
