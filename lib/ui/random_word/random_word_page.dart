import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/core/theme/app_colors.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'package:top_quotes/ui/random_word/bloc/random_word_bloc.dart';
import '../../core/utils/scaffold_messenger/scaffold_messenger.dart';
import '../setting/setting_page.dart';
import '../widgets/cache_network_image.dart';
import '../widgets/progress_indicator_widget.dart';

class RandomWordPage extends StatefulWidget {
  const RandomWordPage({super.key});
  @override
  State<RandomWordPage> createState() => _RandomWordPageState();
}

class _RandomWordPageState extends State<RandomWordPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<RandomWordBloc>().add(FetchRandomWordImagesEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _downloadCurrent(RandomWordState state) {
    if (state.imageUrl.isNotEmpty) {
      CustomScaffoldMessenger.showInfo(message: 'Downloading image...');
      context.read<RandomWordBloc>().add(DownloadRandomWordImageEvent(state.imageUrl));
    } else if (state.randomWord.images.isNotEmpty) {
      final currentIndex = _pageController.hasClients ? _pageController.page?.round() ?? 0 : 0;
      final image = state.randomWord.images[currentIndex];
      final url = image.path.isNotEmpty ? image.path : (image.url.isNotEmpty ? image.url : image.thumbs.large ?? '');
      if (url.isNotEmpty) {
        CustomScaffoldMessenger.showInfo(message: 'Downloading image...');
        context.read<RandomWordBloc>().add(DownloadRandomWordImageEvent(url));
      } else {
        CustomScaffoldMessenger.showWarning(message: 'No image URL available');
      }
    } else {
      CustomScaffoldMessenger.showWarning(message: 'No image to download');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryLight],
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
                const Icon(CupertinoIcons.photo_on_rectangle, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Random Images',
                  style: TextStyle(
                    fontFamily: AppFonts.aboreto,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
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
            if (state.isLoading && state.randomWord.images.isEmpty) {
              return Center(child: KProgressIndicator());
            }
            if (state.randomWord.images.isEmpty) {
              return _buildEmptyState();
            }
            return Column(
              children: [
                const SizedBox(height: 12),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: state.randomWord.images.length,
                    onPageChanged: (index) {
                      final image = state.randomWord.images[index];
                      final imageUrl = image.path.isNotEmpty ? image.path : (image.url.isNotEmpty ? image.url : image.thumbs.large ?? '');
                      context.read<RandomWordBloc>().add(SetImageUrlEvent(imageUrl));
                    },
                    itemBuilder: (context, index) {
                      final image = state.randomWord.images[index];
                      final imageUrl = image.path.isNotEmpty ? image.path : (image.url.isNotEmpty ? image.url : image.thumbs.large ?? '');
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  '${index + 1}/${state.randomWord.images.length}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.aboreto,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: imageUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: KNetworkImage(
                                        width: double.infinity,
                                        imageUrl: imageUrl,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blueishGrey.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.photo,
                                              size: 64,
                                              color: AppColors.chineseSilver,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              'No image URL',
                                              style: TextStyle(
                                                color: AppColors.chineseSilver,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder<RandomWordBloc, RandomWordState>(
        builder: (context, state) => _FabCluster(
          onDownload: () => _downloadCurrent(state),
          onSettings: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingPage()),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.photo_fill_on_rectangle_fill, size: 80, color: AppColors.primary.withValues(alpha: 0.3)),
            const SizedBox(height: 24),
            Text(
              'No images found',
              style: TextStyle(
                fontFamily: AppFonts.aboreto,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Pull down or retry later to fetch a new collection of random images.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.chineseSilver,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.read<RandomWordBloc>().add(FetchRandomWordImagesEvent()),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FabCluster extends StatelessWidget {
  final VoidCallback onDownload;
  final VoidCallback onSettings;
  const _FabCluster({required this.onDownload, required this.onSettings});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StyledFab(
          heroTag: 'download_fab',
          tooltip: 'Download image',
          icon: CupertinoIcons.arrow_down_circle_fill,
          onPressed: onDownload,
        ),
        const SizedBox(height: 12),
        _StyledFab(
          heroTag: 'settings_fab',
          tooltip: 'Settings',
          icon: CupertinoIcons.settings_solid,
          onPressed: onSettings,
        ),
      ],
    );
  }
}

class _StyledFab extends StatelessWidget {
  final String heroTag;
  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  const _StyledFab({super.key, required this.heroTag, required this.tooltip, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        elevation: 6,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Icon(icon, size: 30),
      ),
    );
  }
}

