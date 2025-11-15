import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/quote_detail/bloc/quote_details_bloc.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/utils/scaffold_messenger/scaffold_messenger.dart';
class QuoteDetailPage extends StatefulWidget {
  final int quoteId;
  const QuoteDetailPage({super.key, required this.quoteId});
  @override
  State<QuoteDetailPage> createState() => _QuoteDetailPageState();
}
class _QuoteDetailPageState extends State<QuoteDetailPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    context.read<QuoteDetailsBloc>().add(
      FetchQuoteDetailsEvent(quoteId: widget.quoteId),
    );
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: AppColors.primaryLight.withValues(alpha: 0.05),
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
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.format_quote_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                gapW8,
                Text(
                  'Quote Details',
                  style: AppTextStyles.subtitle.copyWith(
                    fontFamily: AppFonts.aboreto,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            centerTitle: true,
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
                    onPressed: () {
                      context.read<QuoteDetailsBloc>().add(
                        FetchQuoteDetailsEvent(quoteId: widget.quoteId),
                      );
                      _animationController.reset();
                      _animationController.forward();
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              gapW8,
            ],
          ),
        ),
      ),
      body: BlocListener<QuoteDetailsBloc, QuoteDetailsState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            CustomScaffoldMessenger.showError(error: state.errorMessage);
          }
        },
        child: BlocBuilder<QuoteDetailsBloc, QuoteDetailsState>(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.isLoading,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    gapH16,
                    FadeTransition(
                      opacity: _animationController,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeOutCubic,
                        )),
                        child: QuoteWidget(quote: state.quote, style: QuoteCardStyle.surface),
                      ),
                    ),
                    gapH24,
                    FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.3),
                              AppColors.primaryLight.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              blurRadius: 16,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'What do you think?',
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: AppColors.primary,
                                letterSpacing: 0.6,
                              ),
                            ),
                            gapH16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: VoteButton(
                                    icon: Icons.arrow_upward_rounded,
                                    label: 'Upvote',
                                    isActive: state.quote.userDetails.upvote,
                                    activeColor: AppColors.blue,
                                    activeIconColor: Colors.white,
                                    tooltip: state.quote.userDetails.upvote ? 'Remove upvote' : 'Upvote this quote',
                                    onPressed: () {
                                      state.quote.userDetails.upvote
                                          ? context.read<QuoteDetailsBloc>().add(ClearVoteOnQuoteEvent(id: state.quote.id))
                                          : context.read<QuoteDetailsBloc>().add(QuoteUpvoteEvent(id: state.quote.id));
                                    },
                                  ),
                                ),
                                gapW12,
                                Expanded(
                                  child: VoteButton(
                                    icon: Icons.arrow_downward_rounded,
                                    label: 'Downvote',
                                    isActive: state.quote.userDetails.downvote,
                                    activeColor: AppColors.orange,
                                    activeIconColor: Colors.white,
                                    tooltip: state.quote.userDetails.downvote ? 'Remove downvote' : 'Downvote this quote',
                                    onPressed: () {
                                      state.quote.userDetails.downvote
                                          ? context.read<QuoteDetailsBloc>().add(ClearVoteOnQuoteEvent(id: state.quote.id))
                                          : context.read<QuoteDetailsBloc>().add(QuoteDownVoteEvent(id: state.quote.id));
                                    },
                                  ),
                                ),
                                gapW12,
                                Expanded(
                                  child: VoteButton(
                                    icon: state.quote.userDetails.favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                    label: 'Favorite',
                                    isActive: state.quote.userDetails.favorite,
                                    activeColor: AppColors.red,
                                    activeIconColor: Colors.white,
                                    tooltip: state.quote.userDetails.favorite ? 'Remove from favorites' : 'Add to favorites',
                                    onPressed: () {
                                      state.quote.userDetails.favorite
                                          ? context.read<QuoteDetailsBloc>().add(RemoveQuoteFromFavoritesEvent(id: state.quote.id))
                                          : context.read<QuoteDetailsBloc>().add(AddQuoteToFavoritesEvent(id: state.quote.id));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapH24,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class VoteButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color activeIconColor;
  final String tooltip;
  final VoidCallback onPressed;
  const VoteButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.activeIconColor,
    required this.tooltip,
    required this.onPressed,
  });
  @override
  State<VoteButton> createState() => _VoteButtonState();
}
class _VoteButtonState extends State<VoteButton> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut));
  }
  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTapDown: (_) => _scaleController.forward(),
          onTapUp: (_) {
            _scaleController.reverse();
            widget.onPressed();
          },
          onTapCancel: () => _scaleController.reverse(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: widget.isActive
                  ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [widget.activeColor, widget.activeColor.withValues(alpha: 0.8)])
                  : null,
              color: widget.isActive ? null : AppColors.blueishGrey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isActive ? widget.activeColor : AppColors.chineseSilver.withValues(alpha: 0.3),
                width: widget.isActive ? 2 : 1.5,
              ),
              boxShadow: widget.isActive
                  ? [BoxShadow(color: widget.activeColor.withValues(alpha: 0.3), blurRadius: 12, spreadRadius: 0, offset: const Offset(0, 4))]
                  : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                  child: Icon(widget.icon, key: ValueKey<bool>(widget.isActive), color: widget.isActive ? widget.activeIconColor : AppColors.chineseSilver, size: 26),
                ),
                const SizedBox(height: 6),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: AppTextStyles.caption.copyWith(
                    color: widget.isActive ? widget.activeIconColor : AppColors.chineseSilver,
                    fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                  child: Text(widget.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
