import 'package:flutter/material.dart';
import 'package:top_quotes/domain/entities/quote.dart';
import 'package:top_quotes/ui/widgets/quote_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView.builder(itemBuilder: (context,index){
        return QuoteWidget(quote: Quote.empty());
      })
    );
  }
}
