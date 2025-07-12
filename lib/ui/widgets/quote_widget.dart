import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/domain/entities/quote.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';

class QuoteWidget extends StatelessWidget {
  final Quote quote;
  final void Function()? onTap;
  const QuoteWidget({super.key, required this.quote, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryLight.withOpacity(0.7),
                  AppColors.primary.withOpacity(0.9),
                ],
              ),
              boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 4),
          ) ],
        ),
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.format_quote,
                  size: 60,
                  color: Colors.white.withOpacity(0.15)),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quote text with animated entrance
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: SelectableText(
                      "\"${quote.body}\"",
                      key: ValueKey<String>(quote.body),
                      style: AppTextStyles.body.copyWith(
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Author with stylish divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SelectableText(
                          quote.author ?? "Unknown",
                          style: AppTextStyles.caption.copyWith(
                            fontFamily: GoogleFonts.montserrat().fontFamily,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            overflow: TextOverflow.fade
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tags with fade animation
                  if (quote.tags.isNotEmpty)
                    ...[AnimatedOpacity(
                      opacity: 1,
                      duration: const Duration(milliseconds: 700),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: quote.tags.map((tag) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          child: Text(
                            tag,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Stats with modern icons
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          Icons.arrow_upward,
                          quote.upvotesCount.toString(),
                          Colors.green[200]!,
                        ),
                        _buildStatItem(
                          Icons.arrow_downward,
                          quote.downvotesCount.toString(),
                          Colors.amber[200]!,
                        ),
                        _buildStatItem(
                          Icons.favorite,
                          quote.favoritesCount.toString(),
                          Colors.pink[200]!,
                        ),
                      ],
                    ),
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

  Widget _buildStatItem(IconData icon, String value, Color color) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: 1,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppTextStyles.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}