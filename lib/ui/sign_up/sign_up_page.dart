import 'package:flutter/material.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/text_form_field_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("“If you wish to make an apple pie from scratch, you must first create the universe.", style: AppTextStyles.title.copyWith(
              fontFamily: AppFonts.aboreto,
              fontSize: 14,
            )),
            gapH16,
            KTextFormField(
              controller: usernameController,
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
            ),
            gapH24,
            KTextFormField(
              controller: emailController,
              labelText: 'Email',
              prefixIcon: Icon(Icons.alternate_email_outlined),
            ),
            gapH24,
            KTextFormField(
              controller: passwordController,
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_person_outlined),
            ),
            gapH24,
            Text("“History is only the register of crimes and misfortunes.” ", style: AppTextStyles.title.copyWith(
              fontFamily: AppFonts.aboreto,
              fontSize: 14,
            )),
            gapH8,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Register", style: AppTextStyles.subtitle.copyWith(fontFamily: AppFonts.aboreto)),
                gapW12,
                ElevatedButton(
                  onPressed: () {
                    // Handle sign up action
                  },
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
