import 'package:flutter/material.dart';
import 'package:top_quotes/ui/login/bloc/login_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';
import '../home/home_page.dart';
import '../sign_up/sign_up_page.dart';
import '../widgets/text_form_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: padding16,
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
               if(state.isAuthenticated) {
                  // Navigate to HomePage if authentication is successful
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else if (state.errorMessage != null) {
                  // Show error message if authentication fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                bloc: context.read<LoginBloc>(),
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome Back!", style: AppTextStyles.title),
                      gapH12,
                      Text(
                        "Sign in to your account",
                        style: AppTextStyles.body,
                      ),
                      gapH8,
                      KTextFormField(
                        controller: _usernameController,
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline_sharp),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          if (value.length < 3) {
                            return 'Username must be at least 3 characters';
                          }
                          // Add your username validation logic here
                          return null; // Return null if the input is valid
                        },
                      ),
                      gapH16,
                      KTextFormField(
                        controller: _passwordController,
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                          // Add your password validation logic here
                        },
                      ),
                      gapH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sign In",
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.raisinBlack,
                            ),
                          ),
                          gapW12,
                          state.isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // If the form is valid, trigger the login event
                                    context.read<LoginBloc>().add(
                                      LoginWithUsernameAndPassword(
                                        username:
                                            _usernameController.text.toString(),
                                        password:
                                            _passwordController.text.toString(),
                                      ),
                                    );
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.raisinBlack,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Register",
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.lightCrimson,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
