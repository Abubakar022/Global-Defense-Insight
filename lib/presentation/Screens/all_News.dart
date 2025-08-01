import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:global_defense_insight/api/api_Call.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'package:global_defense_insight/presentation/Screens/news_detail_screen.dart';

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  final PostController postController = Get.put(PostController());
  final HtmlUnescape unescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("All News", style: textTheme.headlineLarge),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Obx(() {
        if (postController.postList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: postController.postList.length,
          itemBuilder: (context, index) {
            try {
              final post = postController.postList[index];

              final categoryId =
                  post.categories.isNotEmpty ? post.categories.first : 0;

              final categoryName =
                  postController.categoryMap[categoryId] ?? "News";

              final cleanTitle = unescape.convert(post.title ?? 'No Title');
              final cleanExcerpt = unescape
                  .convert(post.excerpt ?? 'No Description')
                  .replaceAll('[&hellip;]', '')
                  .replaceAll('[...]', '')
                  .trim();
              print("${post.content}");
              return GestureDetector(
                onTap: () => Get.to(() => NewsDetailScreen(post: post)),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🔹 Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              post.imageUrl ?? '',
                              width: double.infinity,
                              height: height * 0.29,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Appcolor.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(categoryName,
                                  style: textTheme.titleMedium),
                            ),
                          ),
                        ],
                      ),

                      Gspace.spaceVertical(10),

                      /// 🔹 Title
                      Text(
                        cleanTitle,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Gspace.spaceVertical(5),

                      /// 🔹 Description
                      Text(
                        cleanExcerpt,
                        style: textTheme.bodyMedium,
                      ),

                      Gspace.spaceVertical(5),

                      /// 🔹 Date
                      Text(
                        post.formattedDate,
                        style: textTheme.headlineLarge!.copyWith(
                          fontSize: 13,
                          color: Appcolor.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } catch (e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Failed to load post #$index: $e",
                    style: textTheme.bodyMedium),
              );
            }
          },
        );
      }),
    );
  }
}
