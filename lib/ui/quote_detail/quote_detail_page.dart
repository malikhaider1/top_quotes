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

class _QuoteDetailPageState extends State<QuoteDetailPage> {
  @override
  void initState() {
    context.read<QuoteDetailsBloc>().add(
      FetchQuoteDetailsEvent(quoteId: widget.quoteId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quote Detail',
          style: AppTextStyles.subtitle.copyWith(fontFamily: AppFonts.aboreto),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<QuoteDetailsBloc>().add(
                FetchQuoteDetailsEvent(quoteId: widget.quoteId),
              );
            },
          ),
        ],
      ),
      body: BlocListener<QuoteDetailsBloc, QuoteDetailsState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            CustomScaffoldMessenger.showError(error: state.errorMessage);
          }
            // Show error message if there is an error
                },
        child: BlocBuilder<QuoteDetailsBloc, QuoteDetailsState>(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.isLoading,
              child: Column(
                children: [
                  gapH16,
                  QuoteWidget(quote: state.quote),
                  Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Upvote Button
                    VoteButton(
                      icon: Icons.arrow_upward,
                      isActive: state.quote.userDetails.upvote,
                      activeColor: AppColors.blue,
                      activeIconColor: Colors.white,
                      tooltip: state.quote.userDetails.upvote
                          ? 'Remove upvote'
                          : 'Upvote',
                      onPressed: () {
                        state.quote.userDetails.upvote
                            ? context.read<QuoteDetailsBloc>().add(
                          ClearVoteOnQuoteEvent(id: state.quote.id),
                        )
                            : context.read<QuoteDetailsBloc>().add(
                          QuoteUpvoteEvent(id: state.quote.id),
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    // Downvote Button
                    VoteButton(
                      icon: Icons.arrow_downward,
                      isActive: state.quote.userDetails.downvote,
                      activeColor: AppColors.orange,
                      activeIconColor: Colors.white,
                      tooltip: state.quote.userDetails.downvote
                          ? 'Remove downvote'
                          : 'Downvote',
                      onPressed: () {
                        state.quote.userDetails.downvote
                            ? context.read<QuoteDetailsBloc>().add(
                          ClearVoteOnQuoteEvent(id: state.quote.id),
                        )
                            : context.read<QuoteDetailsBloc>().add(
                          QuoteDownVoteEvent(id: state.quote.id),
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    // Favorite Button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: state.quote.userDetails.favorite
                            ? AppColors.red.withOpacity(0.15)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 28,
                        color: state.quote.userDetails.favorite
                            ? AppColors.red
                            : AppColors.chineseSilver,
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            state.quote.userDetails.favorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            key: ValueKey<bool>(state.quote.userDetails.favorite),
                          ),
                        ),
                        tooltip: state.quote.userDetails.favorite
                            ? 'Remove from favorites'
                            : 'Add to favorites',
                        onPressed: () {
                          state.quote.userDetails.favorite
                              ? context.read<QuoteDetailsBloc>().add(
                            RemoveQuoteFromFavoritesEvent(id: state.quote.id),
                          )
                              : context.read<QuoteDetailsBloc>().add(
                            AddQuoteToFavoritesEvent(id: state.quote.id),
                          );
                        },
                        splashColor: AppColors.red.withOpacity(0.2),
                        highlightColor: AppColors.red.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),

// Custom Vote Button Widge
                  gapH16,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class VoteButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final Color activeIconColor;
  final String tooltip;
  final VoidCallback onPressed;

  const VoteButton({super.key,
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.activeIconColor,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isActive ? activeColor : AppColors.chineseSilver,
            width: isActive ? 0 : 1.5,
          ),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: activeColor.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: Material(
          color: isActive ? activeColor : Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(30),
            splashColor: activeColor.withOpacity(0.3),
            highlightColor: activeColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Icon(
                  icon,
                  key: ValueKey<bool>(isActive),
                  color: isActive ? activeIconColor : AppColors.chineseSilver,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}