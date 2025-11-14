import 'package:flutter/material.dart';
import 'package:top_quotes/core/app_assets/app_assets.dart';
import '../../core/utils/gradient_text.dart';
import '../../core/utils/url_launcher_helper.dart';
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(AppAssets.logoNoBackground, // Your logo asset
                height: 120,
                width: 120, // Add explicit width for better control
                fit: BoxFit.cover, // Maintains aspect ratio
              ),
            ),
            // _buildSectionHeader(context, 'Performance'),
            _buildSectionHeader(context, 'Support'),
            _buildListTile(
              context,
              icon: Icons.info,
              title: 'About Us',
              onTap:
                  () => UrlLauncherHelper.launchURL(
                'https://www.patreon.com/ionicerrrrscode/about',
              ),
            ),
            _buildListTile(
              context,
              icon: Icons.paid,
              title: 'Join our Patreon',
              onTap:
                  () => UrlLauncherHelper.launchURL(
                'https://www.patreon.com/IonicErrrrsCode',
              ),
            ),
            _buildListTile(
              context,
              icon: Icons.lock,
              title: 'Privacy Policy',
              onTap:
                  () => UrlLauncherHelper.launchURL(
                'https://ionicerrrrscode.blogspot.com/p/privacy-policy-for-quote-hub.html',
              ),
            ),
            _buildListTile(
              context,
              icon: Icons.gavel,
              title: 'Terms of Service',
              onTap:
                  () => UrlLauncherHelper.launchURL(
                'https://ionicerrrrscode.blogspot.com/p/terms-of-services-for-quote-hub.html',
              ),
            ),
            Spacer(),
            Center(
              child: GestureDetector(
                onTap:
                    () => UrlLauncherHelper.launchURL(
                  'https://play.google.com/store/apps/developer?id=Ionic+Errrrs+Code&hl=en',
                ),
                child: GradientText(
                  'IonicErrrrsCode',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Moved helper methods inside the class, and made them accept BuildContext
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ), // Use constants
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ), // Assuming light background for text
    );
  }

  Widget _buildListTile(
      BuildContext context, { // Pass context
        required IconData icon,
        required String title,
        VoidCallback? onTap,
        IconData? trailIcon,
        Color? trailIconColor,
      }) {
    return Card(
      elevation: 1, // Flat card
      color: Colors.grey[50], // Light background for card
      margin: EdgeInsets.only(
        bottom: 10,
      ), // Use constant
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey), // Example color
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ), // Consistent text style
        trailing: Icon(
          trailIcon ?? Icons.chevron_right,
          size: 18,
          color: trailIconColor ?? Colors.grey,
        ), // Use constant size
        onTap: onTap,
      ),
    );
  }
}
