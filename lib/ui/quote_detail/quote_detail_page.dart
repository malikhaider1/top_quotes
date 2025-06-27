import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/quote_detail/bloc/quote_details_bloc.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';

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
      body: BlocBuilder<QuoteDetailsBloc, QuoteDetailsState>(
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
                    ElevatedButton(
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          state.quote.userDetails.upvote
                              ? AppColors.blue
                              : AppColors.chineseSilver,
                        ),
                      ),
                      onPressed: () {
                        state.quote.userDetails.upvote
                            ? context.read<QuoteDetailsBloc>().add(
                              ClearVoteOnQuoteEvent(id: state.quote.id),
                            )
                            :
                        context.read<QuoteDetailsBloc>().add(
                          QuoteUpvoteEvent(id: state.quote.id),
                        );
                      },
                      child: Icon(Icons.arrow_upward, color: AppColors.white),
                    ),
                    gapW8,
                    ElevatedButton(
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          state.quote.userDetails.downvote
                              ? AppColors.orange
                              : AppColors.chineseSilver,
                        ),
                      ),
                      onPressed: () {
                        state.quote.userDetails.downvote
                            ? context.read<QuoteDetailsBloc>().add(
                          ClearVoteOnQuoteEvent(id: state.quote.id),
                        ):context.read<QuoteDetailsBloc>().add(
                          QuoteDownVoteEvent(id: state.quote.id),
                        );
                      },
                      child: Icon(Icons.arrow_downward, color: AppColors.white),
                    ),
                    gapW8,
                    ElevatedButton(
                      onPressed: () {
                        state.quote.userDetails.favorite
                            ? context.read<QuoteDetailsBloc>().add(
                          RemoveQuoteFromFavoritesEvent(id: state.quote.id),
                        ):
                        context.read<QuoteDetailsBloc>().add(
                          AddQuoteToFavoritesEvent(id: state.quote.id),
                        );
                      },
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          state.quote.userDetails.favorite
                              ? AppColors.red
                              : AppColors.chineseSilver,
                        ),
                      ),
                      child: Icon(
                                state.quote.userDetails.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.white,
                              ),
                    ),
                  ],
                ),
                gapH16,
              ],
            ),
          );
        },
      ),
    );
  }
}
