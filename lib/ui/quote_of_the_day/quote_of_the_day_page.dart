import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/ui/home/bloc/home_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';

class QuoteOfTheDayPage extends StatefulWidget {
  const QuoteOfTheDayPage({super.key});

  @override
  State<QuoteOfTheDayPage> createState() => _QuoteOfTheDayPageState();
}

class _QuoteOfTheDayPageState extends State<QuoteOfTheDayPage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(FetchQuoteOfTheDayEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Quote of the Day',
              style: AppTextStyles.subtitle.copyWith(
                fontFamily: AppFonts.aboreto,
              ),
            ),
          ),
          body: Skeletonizer(
            enabled: state.isLoading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(size8),
                    child: SelectableText(
                      state.quoteOfTheDay.body ?? 'Loading...',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    '- ${state.quoteOfTheDay.author ?? 'Unknown'}',
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<HomeBloc>().add(FetchQuoteOfTheDayEvent());
            },
            child: Icon(Icons.refresh),
          ),
        );
      },
    );
  }
}
