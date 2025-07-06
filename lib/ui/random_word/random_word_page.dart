import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/scaffold_messenger/scaffold_messenger.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/domain/entities/random_word_image.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RandomWordBloc>().add(
            (DownloadRandomWordImageEvent(
              context.read<RandomWordBloc>().state.imageUrl,
            )),
          );
        },
        backgroundColor: AppColors.gradient3,
        child: Icon(CupertinoIcons.download_circle_fill, color: Colors.black),
      ),
      body: BlocListener<RandomWordBloc, RandomWordState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            CustomScaffoldMessenger.showError(error: state.errorMessage);
            context.read<RandomWordBloc>().add(ClearRandomWordErrorEvent());
          }
        },
        child: BlocBuilder<RandomWordBloc, RandomWordState>(
          builder: (context, state) {
            return state.isLoading
                ? Center(child: CircularProgressIndicator())
                : PageView.builder(
                  itemCount: state.randomWord.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    context.read<RandomWordBloc>().add(
                      SetImageUrlEvent(state.randomWord.images[index].path),
                    );
                    return KNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      imageUrl: state.randomWord.images[index].path,
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
