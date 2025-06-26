import 'package:flutter/material.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/domain/entities/quote.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';

class QuoteWidget extends StatelessWidget {
  final Quote quote;
  final void Function()? onTap;
  const QuoteWidget({super.key, required this.quote,this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: size20, vertical: size6),
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
                  "\"${quote.body}\"" ?? "",
                  style: AppTextStyles.body.copyWith(
                    fontFamily: AppFonts.openSans,
                  ),
                ),
                gapH8,
                SelectableText(
                  quote.author ?? "Unknown",
                  style: AppTextStyles.caption.copyWith(
                    fontFamily: AppFonts.aboreto,
                  ),
                ),
                gapH8,
                quote.tags.isNotEmpty
                    ? Wrap(
                      spacing: size8,
                      children:
                          quote.tags
                              .map(
                                (tag) => Chip(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: radius8,
                                  ),
                                  backgroundColor: Colors.white,
                                  surfaceTintColor: AppColors.raisinBlack,
                                  label: Text(
                                    tag,
                                    style: AppTextStyles.caption.copyWith(
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
                        color: Colors.blue,
                        size: size20,
                      ),
                    ),
                    gapW4,
                    Text(
                      quote.upvotesCount.toString(),
                      style: AppTextStyles.caption,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.orange,
                      size: size20,
                    ),
                    gapW4,
                    Text(
                      quote.downvotesCount.toString(),
                      style: AppTextStyles.caption,
                    ),
                    gapW4,
                    Icon(Icons.favorite_border, color: Colors.red, size: size20),
                    gapW4,
                    Text(
                      quote.favoritesCount.toString(),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
