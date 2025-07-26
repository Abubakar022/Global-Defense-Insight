import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/common/Widget/cutom_Drawer.dart';
import 'package:global_defense_insight/controller/news_controller.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
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
  final NewsController newsController = Get.put(NewsController());
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (newsController.topStories.isNotEmpty) {
        _currentPage++;
        if (_currentPage >= newsController.topStories.length) {
          _currentPage = 0;
          _pageController.jumpToPage(0); // no reverse animation
        } else {
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
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

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Padding(
  padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12), // margin from edges
  child: Container(
    decoration: BoxDecoration(
      color: Theme.of(context).secondaryHeaderColor,
      borderRadius: BorderRadius.circular(30), // fully rounded
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black26,
      //     blurRadius: 8,
      //     offset: Offset(0, 4),
      //   ),
      // ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GNav(
        backgroundColor: Colors.transparent, // transparent because Container has color
        color: isDark ? Colors.white : Colors.black,
        activeColor: isDark ? Colors.black : Colors.white,
        tabBackgroundColor: Appcolor.blue,
        gap: 8,
        padding: EdgeInsets.all(16),
        tabs: [
          GButton(icon: Icons.home_rounded, text: "Home"),
          GButton(icon: Icons.find_in_page, text: "Discover"),
          GButton(icon: Icons.trending_up, text: "Trending"),
        ],
      ),
    ),
  ),
),

      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          GestureDetector(
            onTap: () {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.signOut();
              Get.offAll(SignIn());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout_rounded),
            ),
          )
        ],
      ),
      drawer: DrawerWideget(),
      body: SingleChildScrollView(
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
                //   ElevatedButton(
                //       onPressed: () {},
                //       child: Text(
                //         "View All",
                //         style: textTheme.titleSmall,
                //       )
                //       ),
                ],
              ),
              Gspace.spaceVertical(8),
              Obx(() {
                if (newsController.topStories.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  width: double.infinity,
                  height: height * 0.35,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: newsController.topStories.length,
                          itemBuilder: (context, index) {
                            final article = newsController.topStories[index];
                            return Stack(
                              children: [
                                Image.asset(
                                  article.image,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  left: 20,
                                  top: 20,
                                  child:    Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Appcolor.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            article.category,
                            style:  textTheme.titleMedium
                          ),
                        ),
                                ),
                                Positioned(
                                  bottom: 55,
                                  left: 20,
                                  child: Row(
                                    children: [
                                      Text(
                                        article.organization,
                                        style: textTheme.titleMedium,
                                      ),
                                      Gspace.spaceHorizontal(3),
                                      Text(
                                        article.date,
                                        style: textTheme.titleMedium,
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
                                      article.title,
                                      style: textTheme.headlineMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
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
                            count: newsController.topStories.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Appcolor.blue,
                              dotHeight: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Gspace.spaceVertical(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest News",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 24),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "View All",
                        style: textTheme.titleSmall,
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                height: 120,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(25)),
                // child: Container(
                //   width: 0.1,
                //   height: 0.1,
                //   decoration: BoxDecoration(color: Appcolor.blue),
                // ),
                // child: Row(
                //   children: [
                //     Column(
                //       children: [
                //         Image.asset(
                //           "assets/animations/lockhead.jpeg",
                //           height: double.infinity,
                //           width: 120,
                //         ),
                //       ],
                //     )
                //   ],
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
