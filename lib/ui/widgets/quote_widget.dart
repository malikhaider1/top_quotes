import 'package:flutter/material.dart';
import 'package:top_quotes/domain/entities/quote.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';
class QuoteWidget extends StatelessWidget {
  final Quote quote;
  const QuoteWidget({super.key, required this.quote});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding8,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quote.body??"",
                style: AppTextStyles.body,
              ),
             gapH4,
              Row(
                children: [
                  Text(
                    '—${quote.author ?? "Unknown"}',
                    style: AppTextStyles.caption.copyWith(fontFamily: AppFonts.roboto),
                  ),
                  const Spacer(),
                  IconButton(
                    //constraints: BoxConstraints(maxWidth: 15, minHeight: 20),
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      //print('Favorite button pressed');
                    },
                  ),
                  Text("${quote.favoritesCount}",style: AppTextStyles.caption,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}