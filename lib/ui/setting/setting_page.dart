import 'package:flutter/material.dart';
import 'package:top_quotes/core/app_assets/app_assets.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import '../../core/utils/gradient_text.dart';
import '../../core/utils/url_launcher_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryLight],
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
            centerTitle: true,
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
                const Icon(Icons.settings_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: AppFonts.aboreto,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Logo & Name
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.blueishGrey.withValues(alpha: 0.03),
                            AppColors.primaryLight.withValues(alpha: 0.04),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppAssets.logoNoBackground,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Quote Hub',
                      style: AppTextStyles.title.copyWith(
                        fontFamily: AppFonts.aboreto,
                        fontSize: 24,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Support Section
              _buildSectionHeader(context, 'Support & Information'),
              const SizedBox(height: 12),
              _buildListTile(
                context,
                icon: Icons.info_outline_rounded,
                title: 'About Us',
                subtitle: 'Learn more about our mission',
                onTap: () => UrlLauncherHelper.launchURL(
                  'https://www.patreon.com/ionicerrrrscode/about',
                ),
              ),
              const SizedBox(height: 10),
              _buildListTile(
                context,
                icon: Icons.favorite_outline_rounded,
                title: 'Join our Patreon',
                subtitle: 'Support our work',
                onTap: () => UrlLauncherHelper.launchURL(
                  'https://www.patreon.com/IonicErrrrsCode',
                ),
              ),

              const SizedBox(height: 28),

              // Legal Section
              _buildSectionHeader(context, 'Legal'),
              const SizedBox(height: 12),
              _buildListTile(
                context,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'How we handle your data',
                onTap: () => UrlLauncherHelper.launchURL(
                  'https://ionicerrrrscode.blogspot.com/p/privacy-policy-for-quote-hub.html',
                ),
              ),
              const SizedBox(height: 10),
              _buildListTile(
                context,
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                subtitle: 'Our terms and conditions',
                onTap: () => UrlLauncherHelper.launchURL(
                  'https://ionicerrrrscode.blogspot.com/p/terms-of-services-for-quote-hub.html',
                ),
              ),

              const SizedBox(height: 40),

              // Footer
              Center(
                child: Column(
                  children: [
                    Text(
                      'Made with ❤️ by',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.chineseSilver,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => UrlLauncherHelper.launchURL(
                        'https://play.google.com/store/apps/developer?id=Ionic+Errrrs+Code&hl=en',
                      ),
                      child: GradientText(
                        'IonicErrrrsCode',
                        style: TextStyle(
                          letterSpacing: 1.2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to view more apps',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.chineseSilver,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.caption.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blueishGrey.withValues(alpha: 0.02),
            AppColors.primaryLight.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryLight.withValues(alpha: 0.12),
                AppColors.primary.withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(
          title,
          style: AppTextStyles.body.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.raisinBlack,
          ),
        ),
        subtitle: subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 13,
                    color: AppColors.chineseSilver,
                  ),
                ),
              )
            : null,
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.chineseSilver,
        ),
        onTap: onTap,
      ),
    );
  }
}
