import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:klimo/components/stories/quiz/quiz_component.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import '../../common/layout/animated_bar.dart';
import '../../common/cubit/api_get_cubit.dart';
import '../../common/images/custom_network_image.dart';
import '../../common/repository/api_repository.dart';
import '../../common/layout/full_screen_background_overlay.dart';
import '../../common/layout/full_screen_loading.dart';
import '../../common/images/image_utility.dart';
import '../../common/models/attachement.dart';
import 'models/story.dart';
import 'quiz/widgets/quiz_buttons.dart';
import 'widgets/story_page_content.dart';

class StoryPage extends StatelessWidget {
  final String storyId;
  const StoryPage({super.key, required this.storyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ApiGetCubit<StoryDetails>(ApiRepository(
            path: '_/stories/$storyId',
            deserialize: (content) {
              return StoryDetails.fromJson(content['story']);
            },
            isV2: true))
          ..load(),
        child:
            BlocBuilder<ApiGetCubit<StoryDetails>, ApiGetState<StoryDetails>>(
          builder: (context, state) {
            return state?.whenOrNull(
                    data: (data) => _StoryPage(
                        story: data.copyWith(pages: data.pages.toList())),
                    loading: () => const FullScreenLoading()) ??
                const SizedBox();
          },
        ),
      ),
    );
  }
}

class _StoryPage extends StatefulWidget {
  final StoryDetails story;
  const _StoryPage({required this.story});

  @override
  State<_StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<_StoryPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int? _currentQuizIndex;
  bool isLoading = true;

  late final AnimationController _animController;
  static const readingTimeMilliSeconds = 30000;

  List<int> indexLookup = <int>[0, 1, 2, 3];

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: readingTimeMilliSeconds),
    );
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _incrementPage(1);
      }
    });
    _animController.forward();
    // shuffle answer indices
    indexLookup.shuffle();
  }

  void _controlTimeAnimation() {
    _animController.isAnimating
        ? _animController.stop()
        : _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const FullScreenLoading();
    }
    if (widget.story.pages.isEmpty) {
      return Center(
        child: Text(context.localisation().story_no_page),
      );
    }
    final StoryPageModel currentPage = widget.story.pages[_currentIndex];
    Attachement? nextAttachement;
    Attachement? nextIllustration;
    if (widget.story.pages.length > _currentIndex + 1) {
      nextAttachement = widget.story.pages[_currentIndex + 1].image;
      nextIllustration = widget.story.pages[_currentIndex + 1].illustration;
    }

    return GestureDetector(
      onLongPress: () => _animController.stop(),
      onTapUp: (details) {
        if (details.globalPosition.dx < context.media.size.width / 2) {
          _incrementPage(-1);
        } else {
          _incrementPage(1);
        }
      },
      onLongPressUp: () => _animController.forward(),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomNetworkImage.withPlaceholder(
              currentPage.image,
              context,
              fit: BoxFit.cover,
            ),
          ),
          if (nextAttachement != null)
            Offstage(
              offstage: true,
              child:
                  CustomNetworkImage.withPlaceholder(nextAttachement, context),
            ),
          if (nextIllustration != null)
            Offstage(
                offstage: true,
                child: CustomNetworkImage.withPlaceholder(
                    nextIllustration, context)),
          const FullScreenBackgroundOverlay(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 72),
                  StoryPageContent(
                    page: currentPage,
                    storyId: widget.story.id,
                  ),
                  if (currentPage.quiz != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
                        child: QuizComponent(
                          currentQuizIndex: _currentQuizIndex,
                          setCurrentQuizIndex: (index) => setState(() {
                            _currentQuizIndex = index;
                          }),
                          quiz: currentPage.quiz!,
                          storyId: widget.story.id,
                          indexLookup: indexLookup,
                        ),
                      ),
                    ),
                  if (currentPage.quiz != null)
                    QuizButtons(
                      currentQuizIndex: _currentQuizIndex,
                      setCurrentQuizIndex: (index) => setState(() {
                        _currentQuizIndex = index;
                      }),
                      quiz: currentPage.quiz!,
                      storyId: widget.story.id,
                      controlTimeAnimation: () => _controlTimeAnimation(),
                      onNext: () {
                        // leave story at last page & update and store collected points
                        if (_currentIndex == widget.story.pages.length - 1) {
                          Navigator.pop(context);
                        }
                        // shuffle answer indices
                        indexLookup.shuffle();
                        _incrementPage(1);
                      },
                      onNextButtonText:
                          _currentIndex == widget.story.pages.length - 1
                              ? context.localisation().action_done
                              : null,
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: SafeArea(
              child: CloseButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          if (widget.story.pages.length != 1)
            Positioned(
              top: 0.0,
              left: 8.0,
              right: 8.0,
              child: SafeArea(
                child: Row(
                  children: widget.story.pages
                      .asMap()
                      .map((i, e) {
                        return MapEntry(
                          i,
                          AnimatedBar(
                            animController: _animController,
                            position: i,
                            currentIndex: _currentIndex,
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    precacheImages(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  final Map<String, ImageProvider> providers = {};
  Future<void> precacheImages(BuildContext context) async {
    final pages = widget.story.pages;
    //prepare urls using context before the async gaps
    final urls = pages.map((page) => page.image.url);
    final optimizedUrls =
        urls.map((url) => optimizedImageUrl(src: url, context: context));

    //prepare urls using context before the async gaps
    final illustrationUrls = pages
        .map((page) => page.illustration?.url != null
            ? optimizedImageUrl(src: page.illustration!.url, context: context)
            : null)
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
    // make sure first page is cached when showing the story
    await DefaultCacheManager().downloadFile(optimizedUrls.first);
    if (illustrationUrls.isNotEmpty) {
      await DefaultCacheManager().downloadFile(illustrationUrls.first);
    }
    setState(() {
      isLoading = false;
    });
    for (var url in optimizedUrls.skip(1)) {
      DefaultCacheManager().downloadFile(url);
    }
    for (var url in illustrationUrls.skip(1)) {
      DefaultCacheManager().downloadFile(url);
    }
  }

  bool didFinishAnimation = false;
  void _incrementPage([int increment = 1]) {
    if (_currentIndex == widget.story.pages.length - 1 && increment == 1 ||
        didFinishAnimation) {
      didFinishAnimation = true;
      _animController.animateTo(1.0,
          duration: const Duration(milliseconds: 100));
    } else {
      _animController.reset();
      _animController.forward();
    }
    setState(
      () {
        _currentIndex = min(
            widget.story.pages.length - 1, max(0, _currentIndex + increment));
        _currentQuizIndex = null;

        // update reading time for story page
        _animController.duration =
            const Duration(milliseconds: readingTimeMilliSeconds);
      },
    );
  }
}
