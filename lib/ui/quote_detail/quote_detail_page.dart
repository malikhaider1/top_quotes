import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/quote_detail/bloc/quote_details_bloc.dart';
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
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    horizontal: size20,
                    vertical: size6,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: radius20),
                  elevation: 2,
                  child: Padding(
                    padding: padding12,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SelectableText(
                            "\"${state.quote.body}\"" ?? "Loading",
                            style: AppTextStyles.body,
                          ),
                          gapH8,
                          SelectableText(
                            state.quote.author ?? "Unknown",
                            style: AppTextStyles.caption.copyWith(
                              fontFamily: AppFonts.aboreto,
                            ),
                          ),
                          gapH8,
                          state.quote.tags.isNotEmpty
                              ? Wrap(
                                spacing: size8,
                                children:
                                    state.quote.tags
                                        .map(
                                          (tag) => Chip(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: radius8,
                                            ),
                                            backgroundColor: AppColors.white,
                                            surfaceTintColor:
                                                AppColors.raisinBlack,
                                            label: Text(
                                              tag,
                                              style: AppTextStyles.caption
                                                  .copyWith(
                                                    fontSize: size12,
                                                    color: AppColors.lightCrimson,
                                                  ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              )
                              : const SizedBox.shrink(),
                          gapH8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: AppColors.blue,
                                  size: size20,
                                ),
                              ),
                              gapW4,
                              Text(
                                state.quote.upvotesCount.toString(),
                                style: AppTextStyles.caption,
                              ),
                              Icon(
                                Icons.arrow_downward,
                                color: AppColors.orange,
                                size: size20,
                              ),
                              gapW4,
                              Text(
                                state.quote.downvotesCount.toString(),
                                style: AppTextStyles.caption,
                              ),
                              gapW4,
                              Icon(
                                Icons.favorite_border,
                                color: AppColors.red,
                                size: size20,
                              ),
                              gapW4,
                              Text(
                                state.quote.favoritesCount.toString(),
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.blue,
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.arrow_upward, color: AppColors.white),
                    ),
                    gapW8,
                    ElevatedButton(
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          AppColors.orange,
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.arrow_downward, color: AppColors.white),
                    ),
                    gapW8,
                    ElevatedButton(
                      onPressed: () {},
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(AppColors.red),
                      ),
                      child: Icon(Icons.favorite_border, color: AppColors.white),
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
