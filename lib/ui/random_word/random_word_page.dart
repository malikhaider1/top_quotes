import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/scaffold_messenger/scaffold_messenger.dart';
import 'package:top_quotes/ui/random_word/bloc/random_word_bloc.dart';

import '../widgets/cache_network_image.dart';

class RandomWordPage extends StatefulWidget {
  const RandomWordPage({super.key});

  @override
  State<RandomWordPage> createState() => _RandomWordPageState();
}

class _RandomWordPageState extends State<RandomWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<RandomWordBloc, RandomWordState>(
          listener: (context, state) {
            if(state.errorMessage.isNotEmpty) {
              CustomScaffoldMessenger.showError(error: state.errorMessage);
              context.read<RandomWordBloc>().add(ClearRandomWordErrorEvent());
            }
          },
          child: BlocBuilder<RandomWordBloc, RandomWordState>(
            builder: (context, state) {
              return ListView.builder(
                primary: true,
                itemCount: state.randomWord.images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    KNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      imageUrl: state.randomWord.images[index].thumbs.large.toString(),
                    ),
              );
            },
          ),
        ));
  }
}