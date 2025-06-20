import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/ui/home/bloc/home_bloc.dart';

import '../widgets/quote_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: state.allQuotes.quotes.length,
                itemBuilder: (context, index) {
                  return QuoteWidget(quote: state.allQuotes.quotes[index]);
                },
              );
        },
      ),
    );
  }
}
