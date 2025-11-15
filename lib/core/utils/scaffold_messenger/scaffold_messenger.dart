import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

enum SnackVariant { success, error, info, warning }

class CustomScaffoldMessenger {
  static void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    // Maintain backward compatibility but apply our unified styling.
    final snack = _buildSnackBar(
      message: message,
      duration: duration,
      action: action,
      // If a specific background is requested, respect it; otherwise default to info styling.
      backgroundOverride: backgroundColor,
      variant: backgroundColor == null
          ? SnackVariant.info
          : null,
    );

    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }

  static void showError({
    required String error,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showVariantSnackBar(
      message: error,
      duration: duration,
      variant: SnackVariant.error,
    );
  }

  static void showSuccess({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showVariantSnackBar(
      message: message,
      duration: duration,
      variant: SnackVariant.success,
    );
  }

  static void showInfo({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    _showVariantSnackBar(
      message: message,
      duration: duration,
      variant: SnackVariant.info,
    );
  }

  static void showWarning({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showVariantSnackBar(
      message: message,
      duration: duration,
      variant: SnackVariant.warning,
    );
  }

  // Internal helpers
  static void _showVariantSnackBar({
    required String message,
    required Duration duration,
    required SnackVariant variant,
  }) {
    final snack = _buildSnackBar(
      message: message,
      duration: duration,
      variant: variant,
    );
    scaffoldMessengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snack);
  }

  static SnackBar _buildSnackBar({
    required String message,
    required Duration duration,
    SnackBarAction? action,
    SnackVariant? variant,
    Color? backgroundOverride,
  }) {
    final _SnackStyle style = _resolveStyle(variant, backgroundOverride);

    return SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(style.icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: style.background,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      action: action != null
          ? SnackBarAction(
              label: action.label,
              onPressed: action.onPressed,
              textColor: Colors.white,
              disabledTextColor: Colors.white.withValues(alpha: 0.6),
            )
          : null,
    );
  }

  static _SnackStyle _resolveStyle(SnackVariant? variant, Color? backgroundOverride) {
    final Color bg = backgroundOverride ?? () {
      switch (variant) {
        case SnackVariant.error:
          return AppColors.red;
        case SnackVariant.success:
          return Colors.green.shade600;
        case SnackVariant.warning:
          return AppColors.orange;
        case SnackVariant.info:
        default:
          return AppColors.blue;
      }
    }();

    final IconData icon = () {
      switch (variant) {
        case SnackVariant.error:
          return Icons.error_outline_rounded;
        case SnackVariant.success:
          return Icons.check_circle_outline_rounded;
        case SnackVariant.warning:
          return Icons.warning_amber_rounded;
        case SnackVariant.info:
        default:
          return Icons.info_outline_rounded;
      }
    }();

    return _SnackStyle(background: bg, icon: icon);
  }
}

class _SnackStyle {
  final Color background;
  final IconData icon;
  const _SnackStyle({required this.background, required this.icon});
}