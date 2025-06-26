import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/core/theme/app_sizes.dart';
import 'package:top_quotes/core/theme/app_text_styles.dart';
import 'package:top_quotes/ui/home/bloc/home_bloc.dart';
import '../quote_detail/quote_detail_page.dart';
import '../widgets/quote_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Top Quotes',
          style: AppTextStyles.subtitle.copyWith(fontFamily: AppFonts.aboreto),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HomeBloc>().add(FetchAllQuotesEvent(page: 1));
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          _scrollController.addListener(() {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              // Load more quotes when the user scrolls to the bottom
              context.read<HomeBloc>().add(
                FetchAllQuotesEvent(page: state.page + 1),
              );
            }
          });
          return state.isLoading && state.quotes.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                controller: _scrollController,
                itemCount: state.quotes.length + (state.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  return index < state.quotes.length
                      ? QuoteWidget(quote: state.quotes[index],onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuoteDetailPage(
                          quoteId: state.quotes[index].id,
                        ),
                      ),
                    );
                  },)
                      : Padding(
                        padding: EdgeInsets.all(size12),
                        child: Center(child: CircularProgressIndicator()),
                      );
                },
              );
        },
      ),
    );
  }
}
