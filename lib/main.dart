import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:top_quotes/data/rest_api_auth_repository.dart';
import 'package:top_quotes/data/rest_api_quotes_repositories.dart';
import 'package:top_quotes/domain/entities/quote.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';
import 'package:top_quotes/ui/favorite/bloc/favorite_bloc.dart';
import 'package:top_quotes/ui/home/bloc/home_bloc.dart';
import 'package:top_quotes/ui/home/home_page.dart';
import 'package:top_quotes/ui/login/login_page.dart';
import 'package:top_quotes/ui/main_navigation/main_navigation_page.dart';
import 'package:top_quotes/ui/quote_detail/bloc/quote_details_bloc.dart';
import 'package:top_quotes/ui/quote_detail/quote_detail_page.dart';
import 'package:top_quotes/ui/search/bloc/search_bloc.dart';
import 'package:top_quotes/ui/sign_up/bloc/sign_up_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/local_db/local_db_implement.dart';
import 'domain/repositories/auth_repository.dart';
import 'ui/login/bloc/login_bloc.dart';

final getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<QuotesRepository>(RestApiQuotesRepositories());
  getIt.registerSingleton<AuthRepository>(RestApiAuthRepository());
  getIt.registerSingleton<LocalDb>(LocalDbImplementation());
  await getIt<LocalDb>().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  HomeBloc(getIt(), getIt())..add(FetchAllQuotesEvent(page: 1)),
        ),
        BlocProvider(create: (context) => LoginBloc(getIt(), getIt())),
        BlocProvider(create: (context) => SignUpBloc(getIt(), getIt())),
        BlocProvider(create: (context) => SearchBloc(getIt(), getIt())),
        BlocProvider(create: (context) => QuoteDetailsBloc(getIt(), getIt())),
        BlocProvider(
          create:
              (context) =>
                  FavoriteBloc(getIt(), getIt())
                    ..add(FetchFavoriteQuotesEvent(page: 1)),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
      home:
          getIt<LocalDb>().userToken.isNotEmpty
              ? MainNavigationPage()
              : LoginPage(),
      //  home: BlocBuilder<LoginBloc, LoginState>(
      //    builder: (context, state) {
      //      final userToken = getIt<LocalDb>().userToken;
      //      if (userToken.isNotEmpty) {
      //        return MainNavigationPage();
      //      } else {
      //        return LoginPage();
      //      }
      //    },
      // home: const HomePage(),
    );
  }
}
