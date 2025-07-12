import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/ui/sign_up/bloc/sign_up_bloc.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/scaffold_messenger/scaffold_messenger.dart';
import '../main_navigation/main_navigation_page.dart';
import '../widgets/text_form_field_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSignedUp) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainNavigationPage()));
        }
        if (state.errorMessage.isNotEmpty) {
          CustomScaffoldMessenger.showError(
            error: state.errorMessage.toString(),
          );
        }
      },
      child: Scaffold(

        body: Padding(
          padding: padding16,
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "“If you wish to make an apple pie from scratch, you must first create the universe.",
                          style: AppTextStyles.title.copyWith(
                            fontFamily: AppFonts.aboreto,
                            fontSize: 14,
                          ),
                        ),
                        gapH16,
                        KTextFormField(
                          controller: usernameController,
                          labelText: 'Username',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            // Add more validation if needed
                            return null;
                          },
                          prefixIcon: Icon(Icons.person),
                        ),
                        gapH24,
                        KTextFormField(
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Add more validation if needed
                            return null;

                          },
                          controller: emailController,
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                        ),
                        gapH24,
                        KTextFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            // Add more validation if needed
                            return null;
                          },
                          prefixIcon: Icon(Icons.lock_person_outlined),
                        ),
                        gapH24,
                        Text(
                          "“History is only the register of crimes and misfortunes.” ",
                          style: AppTextStyles.title.copyWith(
                            fontFamily: AppFonts.aboreto,
                            fontSize: 14,
                          ),
                        ),
                        gapH8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Register",
                              style: AppTextStyles.subtitle.copyWith(
                                fontFamily: AppFonts.aboreto,
                              ),
                            ),
                            gapW12,
                           state.isLoading?
                              CircularProgressIndicator():
                            ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()) {
                                  // Dispatch the sign-up event
                                  context.read<SignUpBloc>().add(
                                    SignUpWithUsernameAndPassword(
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                                // Handle sign up action
                              },
                              child: Icon(Icons.arrow_forward, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
