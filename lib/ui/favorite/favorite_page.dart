import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/domain/entities/quote.dart';
import 'package:top_quotes/ui/favorite/bloc/favorite_bloc.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';

import '../../core/theme/app_text_styles.dart';
import '../quote_detail/quote_detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Favorite Quotes',
          style:AppTextStyles.subtitle.copyWith(fontFamily: AppFonts.aboreto)), // Assuming you have a subtitle style defined,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<FavoriteBloc>().add(FetchFavoriteQuotesEvent(page: 1));
            },
          ),
        ],
      ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.isLoading,
              child: ListView.builder(
                  itemCount: state.quotes.quotes.length,
                  itemBuilder: (context, index) {
                return QuoteWidget(quote: state.quotes.quotes[index],onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => QuoteDetailPage(
                        quoteId: state.quotes.quotes[index].id,
                      ),
                    ),
                  );
                },);
              }),
            );
          },
        )
    );
  }
}
