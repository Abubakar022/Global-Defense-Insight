import 'package:flutter/material.dart';
import 'package:global_defense_insight/api/api_Call.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/controller/news_controller.dart';

class NewsDetailScreen extends StatelessWidget {
  final PostModel post;

  const NewsDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;

    final postController = Get.find<PostController>(); // ✅ Correct Controller
// Get category map
    final categoryId = post.categories.isNotEmpty ? post.categories.first : 0;
    final categoryName = postController.categoryMap[categoryId] ?? "News";

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // 🖼️ Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl ?? '',
                    width: double.infinity,
                    height: size.height * 0.5,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/animations/lockhead.jpeg"),
                  ),
                ),

                // 🔙 Back Button
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Appcolor.blue,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Appcolor.blue,
                    child: IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                // 🏷️ Category Tag
                Positioned(
                  bottom: 100,
                  left: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Appcolor.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(categoryName, style: textTheme.titleMedium),
                  ),
                ),

                // 📰 Title
                Positioned(
                  left: 20,
                  right: 10,
                  bottom: 50,
                  child: Text(
                    post.title ?? "No Title",
                    style: textTheme.headlineMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // 📅 Date
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: Text(
                    post.formattedDate,
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),

            // 🔽 Description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Global Defense Insight",
                          style:
                              textTheme.headlineLarge!.copyWith(fontSize: 19)),
                      Gspace.spaceHorizontal(8),
                      const Icon(Icons.verified, color: Colors.blue, size: 20),
                    ],
                  ),
                  Gspace.spaceVertical(10),
                  Text(
                    post.content ?? "No description available.",
                    style: textTheme.headlineLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:global_defense_insight/core/AppConstant/appContant.dart';
// import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
// import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
// import 'package:iconsax/iconsax.dart';

// class NewsDetailScreen extends StatelessWidget {
//   // final String imageUrl;
//   // final String title;
//   // final String date;
//   // final String description;

//   // const NewsDetailScreen({
//   //   super.key,
//   //   required this.imageUrl,
//   //   required this.title,
//   //   required this.date,
//   //   required this.description,
//   // });

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var width = size.width;
//     var height = size.height;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final textTheme =
//         isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SingleChildScrollView(
//         physics: ClampingScrollPhysics(),
//         child: Column(
//           children: [
//             Container(
//               height: height * 0.50,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadiusDirectional.only(
//                         bottomEnd: Radius.circular(40),
//                         bottomStart: Radius.circular(40)),
//                     child: Image.asset(
//                       "assets/animations/lockhead.jpeg",
//                       width: double.infinity,
//                       height: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                       top: 27,
//                       left: 15,
//                       child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             shape: CircleBorder(),
//                             padding: EdgeInsets.all(15),
//                             backgroundColor: Appcolor.blue,
//                             iconColor: Colors.white,
//                           ),
//                           child: Icon(Icons.arrow_back))),
//                   Positioned(
//                       top: 27,
//                       right: 15,
//                       child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             shape: CircleBorder(),
//                             padding: EdgeInsets.all(15),
//                             backgroundColor: Appcolor.blue,
//                             iconColor: Colors.white,
//                           ),
//                           child: Icon(Icons.share))),
//                   Positioned(
//                     bottom: 100,
//                     left: 20,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Appcolor.blue,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text("News", style: textTheme.titleMedium),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20,
//                     right: 10,
//                     bottom: 50,
//                     child: Text(
//                       "Horizon Mid-Life Upgrade Programme Reaches Major Milestone for Italy and France",
//                       style: textTheme.headlineMedium,
//                       textAlign: TextAlign.left,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 30,
//                     left: 20,
//                     child: Text(
//                       "July 9 , 2027",
//                       style: textTheme.titleMedium,
//                       textAlign: TextAlign.left,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Gspace.spaceVertical(5),
//             SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text("Global Defense Insight",
//                             style: textTheme.headlineLarge!
//                                 .copyWith(fontSize: 19)),
//                         Gspace.spaceHorizontal(8),
//                         Icon(Icons.verified, color: Colors.blue, size: 20),
//                       ],
//                     ),
//                     Gspace.spaceVertical(3),
//                     Text(
//                       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
//                       style: textTheme.headlineLarge!.copyWith(
//                           fontSize: 16, fontWeight: FontWeight.normal),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
