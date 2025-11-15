import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_text_styles.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/domain/entities/quote.dart';

enum QuoteCardStyle { gradient, surface }

class QuoteWidget extends StatefulWidget {
  final Quote quote;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool compact;
  final QuoteCardStyle style;
  const QuoteWidget({
    super.key,
    required this.quote,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = 20,
    this.compact = false,
    this.style = QuoteCardStyle.gradient,
  });

  @override
  State<QuoteWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSurface = widget.style == QuoteCardStyle.surface;
    final Color primary = AppColors.primary;
    final Color primaryLight = AppColors.primaryLight;

    return Padding(
      padding: widget.padding,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() => _isPressed = true);
            _controller.forward();
          },
          onTapUp: (_) {
            setState(() => _isPressed = false);
            _controller.reverse();
            if (widget.onTap != null) widget.onTap!();
          },
          onTapCancel: () {
            setState(() => _isPressed = false);
            _controller.reverse();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: isSurface ? Colors.white : null,
              gradient: isSurface
                  ? null
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryLight.withValues(alpha: 0.85),
                        primary.withValues(alpha: 0.95),
                      ],
                    ),
              border: isSurface
                  ? Border.all(color: Colors.black.withValues(alpha: 0.05), width: 1)
                  : null,
              boxShadow: [
                if (isSurface)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: _isPressed ? 10 : 16,
                    offset: Offset(0, _isPressed ? 4 : 10),
                  )
                else ...[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: _isPressed ? 8 : 16,
                    spreadRadius: _isPressed ? 0 : 2,
                    offset: Offset(0, _isPressed ? 2 : 6),
                  ),
                  BoxShadow(
                    color: primary.withValues(alpha: 0.2),
                    blurRadius: _isPressed ? 4 : 12,
                    spreadRadius: _isPressed ? 0 : 1,
                    offset: Offset(0, _isPressed ? 1 : 3),
                  ),
                ],
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Stack(
                children: [
                  // Hover/press overlay
                  if (!isSurface)
                    Positioned.fill(
                      child: AnimatedOpacity(
                        opacity: _isPressed ? 0.3 : 0.0,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Decorative quote marks
                  if (!isSurface) ...[
                    Positioned(
                      top: -10,
                      right: -10,
                      child: Icon(
                        Icons.format_quote,
                        size: 80,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: -10,
                      child: Transform.rotate(
                        angle: 3.14159,
                        child: Icon(
                          Icons.format_quote,
                          size: 80,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                  ],

                  // Content
                  Padding(
                    padding: EdgeInsets.all(widget.compact ? 18 : 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '"',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: widget.compact ? 34 : 38,
                                color: isSurface
                                    ? primary.withValues(alpha: 0.4)
                                    : Colors.white.withValues(alpha: 0.45),
                                fontWeight: FontWeight.bold,
                                height: 0.8,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: SelectableText(
                                widget.quote.body,
                                style: AppTextStyles.body.copyWith(
                                  fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                                  fontSize: widget.compact ? 16 : 18,
                                  color: isSurface ? AppColors.raisinBlack : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  height: 1.45,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Author chip
                        Container(
                          decoration: BoxDecoration(
                            color: isSurface
                                ? primary.withValues(alpha: 0.06)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSurface
                                  ? primary.withValues(alpha: 0.12)
                                  : Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: isSurface
                                    ? primary.withValues(alpha: 0.9)
                                    : Colors.white.withValues(alpha: 0.8),
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SelectableText(
                                  widget.quote.author.isNotEmpty ? widget.quote.author : 'Unknown Author',
                                  style: AppTextStyles.caption.copyWith(
                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                    fontSize: widget.compact ? 13 : 14,
                                    color: isSurface ? AppColors.raisinBlack : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tags
                        if (widget.quote.tags.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: widget.quote.tags
                                .take(widget.compact ? 2 : 4)
                                .map(
                                  (tag) => Container(
                                    decoration: BoxDecoration(
                                      gradient: isSurface
                                          ? null
                                          : LinearGradient(
                                              colors: [
                                                Colors.white.withValues(alpha: 0.25),
                                                Colors.white.withValues(alpha: 0.12),
                                              ],
                                            ),
                                      color: isSurface ? primary.withValues(alpha: 0.06) : null,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: isSurface
                                            ? primary.withValues(alpha: 0.18)
                                            : Colors.white.withValues(alpha: 0.25),
                                        width: 1,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.tag,
                                          size: 11,
                                          color: isSurface
                                              ? primary.withValues(alpha: 0.85)
                                              : Colors.white.withValues(alpha: 0.85),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          tag,
                                          style: AppTextStyles.caption.copyWith(
                                            fontSize: 11,
                                            color: isSurface ? AppColors.raisinBlack : Colors.white,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],

                        const SizedBox(height: 14),

                        // Stats row
                        Container(
                          decoration: BoxDecoration(
                            gradient: isSurface
                                ? null
                                : LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.18),
                                      Colors.white.withValues(alpha: 0.08),
                                    ],
                                  ),
                            color: isSurface ? primary.withValues(alpha: 0.05) : null,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSurface
                                  ? primary.withValues(alpha: 0.15)
                                  : Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                Icons.arrow_upward_rounded,
                                widget.quote.upvotesCount.toString(),
                                isSurface ? primary : Colors.greenAccent,
                                isSurface: isSurface,
                              ),
                              Container(
                                width: 1,
                                height: 24,
                                color: (isSurface ? primary : Colors.white).withValues(alpha: 0.3),
                              ),
                              _buildStatItem(
                                Icons.arrow_downward_rounded,
                                widget.quote.downvotesCount.toString(),
                                isSurface ? AppColors.orange : Colors.orangeAccent,
                                isSurface: isSurface,
                              ),
                              Container(
                                width: 1,
                                height: 24,
                                color: (isSurface ? primary : Colors.white).withValues(alpha: 0.3),
                              ),
                              _buildStatItem(
                                Icons.favorite_rounded,
                                widget.quote.favoritesCount.toString(),
                                isSurface ? AppColors.red : Colors.pinkAccent,
                                isSurface: isSurface,
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
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, Color color, {bool isSurface = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isSurface ? 0.08 : 0.25),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withValues(alpha: isSurface ? 0.2 : 0.4),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 12,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppTextStyles.caption.copyWith(
              color: isSurface ? AppColors.raisinBlack : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class QuoteWidgetSkeleton extends StatelessWidget {
  final double horizontalPadding;
  const QuoteWidgetSkeleton({super.key, this.horizontalPadding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
    );
  }
}
