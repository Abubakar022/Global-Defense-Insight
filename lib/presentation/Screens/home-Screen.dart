import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/api/api_Call.dart';
import 'package:global_defense_insight/common/Widget/cutom_Drawer.dart';
import 'package:global_defense_insight/common/Widget/post_card_widget.dart';
import 'package:global_defense_insight/controller/news_controller.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'package:global_defense_insight/presentation/Screens/all_News.dart';
import 'package:global_defense_insight/presentation/Screens/discover_Screen.dart';
import 'package:global_defense_insight/presentation/Screens/news_detail_screen.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostController postController = Get.put(PostController());
 
  final PageController _pageController = PageController();
  var postList = <PostModel>[].obs;

  Timer? _timer;
  int _currentPage = 0;

  int _selectedIndex = 0; // ✅ Track selected tab

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _waitForImagesThenStartAutoScroll();
  }

void _waitForImagesThenStartAutoScroll() async {
  // Small wait to ensure PostController has data
  await Future.delayed(Duration(milliseconds: 500));

  final topPosts = postController.postList.take(4).toList();

  List<Future<void>> futures = [];

  for (var post in topPosts) {
    final imageUrl = post.imageUrl ?? '';
    if (imageUrl.isEmpty) continue;

    final image = NetworkImage(imageUrl);
    final completer = Completer<void>();

    final stream = image.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        completer.complete();
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        completer.complete(); // Still complete to prevent blocking
      },
    );

    stream.addListener(listener);
    futures.add(completer.future);

    // Optional cleanup
    completer.future.whenComplete(() {
      stream.removeListener(listener);
    });
  }

  await Future.wait(futures);

  // Start auto-scroll only after all 4 images are loaded
  _startAutoScroll();
}

void _startAutoScroll() {
  _timer = Timer.periodic(Duration(seconds: 4), (_) {
    final topCount = postController.postList.length >= 4
        ? 4
        : postController.postList.length;

    if (topCount > 0 && _pageController.hasClients) {
      _currentPage++;
      if (_currentPage >= topCount) {
        _currentPage = 0;
        _pageController.jumpToPage(0); // Jump without animation
      } else {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }
  });
}


  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;

    /// ✅ List of pages to show on bottom nav tap
    final List<Widget> pages = [
      home_Screen(
        // 👈 your existing home layout
        
        postController: postController,
        height: height,
        pageController: _pageController,
        textTheme: textTheme,
        width: width,
        postLength: postList.length,
      ),
      DiscoverScreen(), // your existing screen
      AllNews(), // your existing screen
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      drawer: DrawerWideget(),

      // ✅ Switch content based on tab
      body: pages[_selectedIndex],

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: GNav(
              backgroundColor: Colors.transparent,
              color: isDark ? Colors.white : Colors.black,
              activeColor: isDark ? Colors.black : Colors.white,
              tabBackgroundColor: Appcolor.blue,
              gap: 8,
              padding: EdgeInsets.all(16),
              selectedIndex: _selectedIndex, // ✅ this line
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index; // ✅ update index when tab is changed
                });
              },
              tabs: [
                GButton(icon: Icons.home_rounded, text: "Home"),
                GButton(icon: Icons.find_in_page, text: "Discover"),
                GButton(icon: Icons.trending_up, text: "Trending"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class home_Screen extends StatelessWidget {
  const home_Screen({
    super.key,
    
    required this.postController,
    required this.height,
    required PageController pageController,
    required this.textTheme,
    required this.width,
    required this.postLength,
  }) : _pageController = pageController;

 
  final PostController postController;
  final double height;
  final PageController _pageController;
  final TextTheme textTheme;
  final double width;
  final int postLength;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Stories",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            Gspace.spaceVertical(8),
            Obx(() {
              final topStories = postController.topStories;
              final latestNews = postController.latestNews;

              if (topStories.isEmpty && latestNews.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: height * 0.35,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: topStories.length,
                                itemBuilder: (context, index) {
                                  final article = topStories[index];
                                  final categoryId =
                                      article.categories.isNotEmpty
                                          ? article.categories.first
                                          : 0;
                                  final category =
                                      postController.categoryMap[categoryId] ??
                                          'News';
                                  return GestureDetector(
                                    onTap: () => Get.to(
                                        () => NewsDetailScreen(post: article)),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          article.imageUrl ?? '',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              Container(
                                                  color: Colors.grey[300],
                                                  child:
                                                      Icon(Icons.broken_image)),
                                        ),
                                        Positioned(
                                          left: 20,
                                          top: 20,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Appcolor.blue,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(category,
                                                style: textTheme.titleMedium),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 75,
                                          left: 20,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Global Defense Insight",
                                                style: textTheme.titleMedium,
                                              ),
                                              Gspace.spaceHorizontal(3),
                                              Text(
                                                article.formattedDate,
                                                style: textTheme.titleMedium!
                                                    .copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: Colors.white
                                              , // 🔵 Blue underline
                                                  decorationThickness:
                                                      1.5, // (Optional) thickness of underline
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 20,
                                          bottom: 30,
                                          child: Container(
                                            width: width * 0.7,
                                            child: Text(
                                              article.title ?? '',
                                              style: textTheme.headlineMedium,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: SmoothPageIndicator(
                                  controller: _pageController,
                                  count: topStories.length,
                                  effect: ExpandingDotsEffect(
                                    activeDotColor: Appcolor.blue,
                                    dotHeight: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gspace.spaceVertical(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Latest News", style: textTheme.headlineLarge),
                          TextButton(
                            onPressed: () {},
                            child:
                                Text("View All", style: textTheme.titleSmall),
                          )
                        ],
                      ),
                      Gspace.spaceVertical(10),
                     
                        ListView.builder(
                          shrinkWrap: true,
                          //physics: BouncingScrollPhysics(),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: latestNews.length,
                          itemBuilder: (context, index) {
                            final post = latestNews[index];
                            final categoryId = post.categories.isNotEmpty
                                ? post.categories.first
                                : 0;
                            final categoryName =
                                postController.categoryMap[categoryId] ?? 'News';
                            return GestureDetector(
                              onTap: () =>
                                  Get.to(() => NewsDetailScreen(post: post)),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: PostCardWidget(
                                  title: post.title ?? 'Failed to load Title',
                                  imagePath: post.imageUrl ?? '',
                                  date: post.formattedDate,
                                  category: categoryName,
                                ),
                              ),
                            );
                          },
                        ),
                      
                    ],
                  ),
                ),
              );
            }),
           

            // PostCardWidget(
            //   imagePath: 'assets/animations/lockhead.jpeg',
            //   category: 'LAND',
            //   title:
            //       'Horizon Mid-Life Upgrade Programme Reaches Major Milestone for Italy and France',
            //   date: 'May 16, 2025',
            // ),
          ],
        ),
      ),
    );
  }
}
