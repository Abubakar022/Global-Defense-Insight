import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/api/api_Call.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/common/Widget/post_card_widget.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'package:global_defense_insight/presentation/Screens/news_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final PostController postController = Get.put(PostController());

  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  List<PostModel> get filteredPosts {
    final allPosts = postController.postList;

    return allPosts.where((post) {
      final categoryId = post.categories.isNotEmpty ? post.categories.first : 0;
      final categoryName =
          postController.categoryMap[categoryId]?.toLowerCase() ?? "unknown";

      final matchesCategory = selectedCategory == 'All' ||
          categoryName == selectedCategory.toLowerCase();

      final matchesSearch = post.title
              ?.toLowerCase()
              .contains(_searchController.text.toLowerCase()) ??
          false;

      return matchesCategory && matchesSearch;
    }).toList();
  }

  Widget buildShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.shade300,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 15,
                          width: double.infinity,
                          color: Colors.grey),
                      SizedBox(height: 10),
                      Container(height: 15, width: 100, color: Colors.grey),
                      SizedBox(height: 10),
                      Container(height: 15, width: 60, color: Colors.grey),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
        title: Text("Discover", style: textTheme.headlineLarge),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Obx(() {
        if (postController.postList.isEmpty &&
            postController.categoryMap.isEmpty) {
          return buildShimmer();
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                
                Text("News from All Over the World",
                    style: textTheme.headlineLarge!.copyWith(fontSize: 17)),
                Gspace.spaceVertical(10),

                /// 🔍 Search Bar
                SearchBar(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  hintText: "Search News ...",
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).secondaryHeaderColor),
                  leading: Icon(Icons.search,
                      color: isDark ? Colors.white : Colors.black),
                  trailing: [
                    IconButton(
                      icon: Icon(Icons.clear,
                          color: isDark ? Colors.white : Colors.black),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  ],
                ),

                Gspace.spaceVertical(10),

                /// 🟦 Horizontal Category Chips
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: postController.categoryMap.length + 1,
                    itemBuilder: (context, index) {
                      final categoryName = index == 0
                          ? 'All'
                          : postController.categoryMap.values
                              .elementAt(index - 1);

                      final isSelected = selectedCategory.toLowerCase() ==
                          categoryName.toLowerCase();

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          backgroundColor:
                              Theme.of(context).secondaryHeaderColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // 👈 more rounded
                          ),
                          label: Text(categoryName,
                              style: textTheme.bodyLarge?.copyWith(
                                  color: isDark
                                      ? Appcolor.darkFontColor
                                      : Appcolor.lightFontColor,
                                  fontWeight: FontWeight.w500)),
                          selected: isSelected,
                          selectedColor: Appcolor.blue,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = categoryName;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                Gspace.spaceVertical(10),

                /// 📰 News List
                Expanded(
                  child: filteredPosts.isEmpty
                      ? Center(
                          child: Text(
                            "No news found.",
                            style: textTheme.titleMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredPosts.length,
                          itemBuilder: (context, index) {
                            final post = filteredPosts[index];
                            final categoryId = post.categories.isNotEmpty
                                ? post.categories.first
                                : 0;
                            final categoryName =
                                postController.categoryMap[categoryId] ??
                                    "News";

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () =>
                                    Get.to(() => NewsDetailScreen(post: post)),
                                child: PostCardWidget(
                                  title: post.title ?? 'No title available',
                                  imagePath: post.imageUrl ?? '',
                                  date: post.formattedDate,
                                  category: categoryName,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:global_defense_insight/api/api_Call.dart';
// import 'package:global_defense_insight/core/AppConstant/appContant.dart';

// import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
// import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
// import 'package:global_defense_insight/common/Widget/post_card_widget.dart';
// import 'package:global_defense_insight/model/post_Model.dart';
// import 'package:global_defense_insight/presentation/Screens/news_detail_screen.dart';

// class DiscoverScreen extends StatefulWidget {
//   const DiscoverScreen({super.key});

//   @override
//   State<DiscoverScreen> createState() => _DiscoverScreenState();
// }

// class _DiscoverScreenState extends State<DiscoverScreen> {
//   final PostController postController = Get.put(PostController());

//   String selectedCategory = 'All';
//   final TextEditingController _searchController = TextEditingController();

//   List<PostModel> get filteredPosts {
//     final allPosts = postController.postList;

//     return allPosts.where((post) {
//       final categoryId = post.categories.isNotEmpty ? post.categories.first : 0;
//       final categoryName =
//           postController.categoryMap[categoryId]?.toLowerCase() ?? "unknown";

//       final matchesCategory = selectedCategory == 'All' ||
//           categoryName == selectedCategory.toLowerCase();

//       final matchesSearch = post.title
//               ?.toLowerCase()
//               .contains(_searchController.text.toLowerCase()) ??
//           false;

//       return matchesCategory && matchesSearch;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final textTheme =
//         isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
//       ),
//       body: Obx(() {
//         if (postController.postList.isEmpty && postController.categoryMap.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Discover", style: Theme.of(context).textTheme.headlineLarge),
//                 Gspace.spaceVertical(5),
//                 Text("News from All Over the World",
//                     style: textTheme.headlineLarge!.copyWith(fontSize: 17)),
//                 Gspace.spaceVertical(10),

//                 /// 🔍 Search Bar
//                 SearchBar(
//                   controller: _searchController,
//                   onChanged: (_) => setState(() {}),
//                   hintText: "Search News ...",
//                   backgroundColor: WidgetStateProperty.all(
//                       Theme.of(context).secondaryHeaderColor),
//                   leading: Icon(Icons.search,
//                       color: isDark ? Colors.white : Colors.black),
//                   trailing: [
//                     IconButton(
//                       icon: Icon(Icons.clear,
//                           color: isDark ? Colors.white : Colors.black),
//                       onPressed: () {
//                         _searchController.clear();
//                         setState(() {});
//                       },
//                     )
//                   ],
//                 ),

//                 Gspace.spaceVertical(10),

//                 /// 🟦 Horizontal Category Chips
//                 SizedBox(
//                   height: 40,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: postController.categoryMap.length + 1,
//                     itemBuilder: (context, index) {
//                       final categoryName = index == 0
//                           ? 'All'
//                           : postController.categoryMap.values.elementAt(index - 1);

//                       final isSelected = selectedCategory.toLowerCase() ==
//                           categoryName.toLowerCase();

//                       return Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: ChoiceChip(
//                           label: Text(categoryName),
//                           selected: isSelected,
//                           selectedColor: Appcolor.blue,
//                           onSelected: (_) {
//                             setState(() {
//                               selectedCategory = categoryName;
//                             });
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 Gspace.spaceVertical(10),

//                 /// 📰 News List
//                 Expanded(
//                   child: filteredPosts.isEmpty
//                       ? Center(
//                           child: Text(
//                             "No news found.",
//                             style: textTheme.titleMedium,
//                           ),
//                         )
//                       : ListView.builder(
//                           itemCount: filteredPosts.length,
//                           itemBuilder: (context, index) {
//                             final post = filteredPosts[index];
//                             final categoryId = post.categories.isNotEmpty
//                                 ? post.categories.first
//                                 : 0;
//                             final categoryName = postController.categoryMap[categoryId] ?? "News";

//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: GestureDetector(
//                                 onTap: () => Get.to(() => NewsDetailScreen(post: post)),
//                                 child: PostCardWidget(
//                                   title: post.title ?? 'No title available',
//                                   imagePath: post.imageUrl ?? '',
//                                   date: post.formattedDate,
//                                   category: categoryName,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
