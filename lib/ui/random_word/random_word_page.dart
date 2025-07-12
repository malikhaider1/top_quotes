import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/ui/random_word/bloc/random_word_bloc.dart';
import '../../core/utils/scaffold_messenger/scaffold_messenger.dart';
import '../setting/setting_page.dart';
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              CustomScaffoldMessenger.showSnackBar(message: "Downloading......",duration: Durations.medium3);
              context.read<RandomWordBloc>().add(
                (DownloadRandomWordImageEvent(
                  context.read<RandomWordBloc>().state.imageUrl,
                )),
              );
            },
            // backgroundColor: Colors.orange.shade50,
            backgroundColor: AppColors.primary,
            child: Icon(CupertinoIcons.download_circle, color: Colors.white,size: 30,),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'settings',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
            },
            // backgroundColor: Colors.orange.shade50,
            backgroundColor: AppColors.primary,
            child: Icon(CupertinoIcons.settings, color: Colors.white,size: 30),
          ),
        ],
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
            return state.isLoading && state.randomWord.images.isEmpty
                ? Center(child: CircularProgressIndicator(color: AppColors.primary,))
                : PageView.builder(
                  itemCount: state.randomWord.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    context.read<RandomWordBloc>().add(
                      SetImageUrlEvent(state.randomWord.images[index].path),
                    );
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (index==0)? Text(
                      "Swipe left to see more images-->",
                      style: TextStyle(fontSize: 16,fontFamily: AppFonts.aboreto),
                    ):SizedBox.shrink(),
                        KNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: state.randomWord.images[index].path,
                        ),
                      ],
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
