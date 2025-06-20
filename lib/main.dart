import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:top_quotes/data/rest_api_auth_repository.dart';
import 'package:top_quotes/data/rest_api_quotes_repositories.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';
import 'package:top_quotes/ui/home/bloc/home_bloc.dart';
import 'package:top_quotes/ui/login/login_page.dart';
import 'core/theme/app_theme.dart';
import 'domain/repositories/auth_repository.dart';
import 'ui/login/bloc/login_bloc.dart';
final getIt = GetIt.instance;
void main() {
  getIt.registerSingleton<QuotesRepository>(RestApiQuotesRepositories());
  getIt.registerSingleton<AuthRepository>(RestApiAuthRepository());

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => HomeBloc(getIt())..add(FetchAllQuotesEvent(page: 1))),
    BlocProvider(create: (context) => LoginBloc(getIt())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes',
      theme: AppTheme().theme,
      home: const LoginPage(),
    );
  }
}
