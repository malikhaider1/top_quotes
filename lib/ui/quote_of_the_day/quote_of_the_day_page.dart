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
    super.initState();
    context.read<HomeBloc>().add(FetchQuoteOfTheDayEvent());
  }

  void _refresh() {
    context.read<HomeBloc>().add(FetchQuoteOfTheDayEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          // Important: don't touch the scaffold background here,
          // it will follow the app theme like other screens.
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
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
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wb_sunny_rounded, color: Colors.white),
                    gapW8,
                    Text(
                      'Quote of the Day',
                      style: AppTextStyles.subtitle.copyWith(
                        fontFamily: AppFonts.aboreto,
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      tooltip: 'Refresh quote',
                      icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                      onPressed: _refresh,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(size16),
              child: Skeletonizer(
                enabled: state.isLoading,
                child: _buildBodyContent(state),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _refresh,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('New quote'),
          ),
        );
      },
    );
  }

  Widget _buildBodyContent(HomeState state) {
    final quote = state.quoteOfTheDay;

    // Basic error / empty handling if needed
    final hasBody = quote.body.trim().isNotEmpty;
    final hasAuthor = quote.author.trim().isNotEmpty;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          padding: EdgeInsets.all(size20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: AppColors.chineseSilver,
                      ),
                      gapW8,
                      Text(
                        'Today\'s inspiration',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.chineseSilver,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                  if (!state.isLoading)
                    Icon(
                      Icons.format_quote_rounded,
                      size: 26,
                      color: AppColors.primary,
                    ),
                ],
              ),
              gapH16,
              SelectableText(
                hasBody ? quote.body : 'Tap the refresh button to get today\'s quote.',
                textAlign: TextAlign.center,
                style: AppTextStyles.title.copyWith(
                  fontSize: 22,
                  height: 1.5,
                  color: AppColors.raisinBlack,
                ),
              ),
              gapH16,
              Align(
                alignment: Alignment.centerRight,
                child: SelectableText(
                  hasAuthor ? '- ${quote.author}' : '- Unknown',
                  style: AppTextStyles.body.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: AppColors.chineseSilver,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
