import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:global_defense_insight/model/category_Model.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'package:http/io_client.dart';

class PostController extends GetxController {
  RxList<PostModel> postList = <PostModel>[].obs;
  List<PostModel> get topStories => postList.take(4).toList();
List<PostModel> get latestNews => postList.skip(4).toList();

  Map<int, String> categoryMap = {}; // ID → Name

  // 👇 Create a custom HttpClient that skips SSL cert verification (only for development)
  IOClient getUnsafeClient() {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCategories();
    await getNewsData();
  }

 Future<void> getCategories() async {
  final client = getUnsafeClient();
  final response = await client.get(
    Uri.parse('https://defensetalks.com/wp-json/wp/v2/categories?per_page=100'),
  );

  if (response.statusCode == 200) {
    final List decoded = jsonDecode(response.body);

    // Use Set to track unique names
    final Set<String> addedNames = {};

    for (var item in decoded) {
      final category = CategoryModel.fromJson(item);
      final name = category.name.trim();

      if (!addedNames.contains(name)) {
        categoryMap[category.id] = name;
        addedNames.add(name);
      }
    }
  } else {
    print('Failed to load categories: ${response.statusCode}');
  }
}


  Future<void> getNewsData() async {
    final client = getUnsafeClient();
    final response = await client.get(
      Uri.parse('https://defensetalks.com/wp-json/wp/v2/posts?per_page=30'),
    );

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      postList.value = decoded.map((json) => PostModel.fromJson(json)).toList();
    } else {
      print('Failed to load posts: ${response.statusCode}');
    }
  }

//   Future<void> getNewsData() async {
//   final client = getUnsafeClient();
//   int page = 1;
//   bool hasMore = true;
//   List<PostModel> allPosts = [];

//   while (hasMore) {
//     final response = await client.get(
//       Uri.parse('https://defensetalks.com/wp-json/wp/v2/posts?per_page=100&page=$page'),
//     );

//     if (response.statusCode == 200) {
//       final List decoded = jsonDecode(response.body);
//       if (decoded.isEmpty) {
//         hasMore = false;
//       } else {
//         allPosts.addAll(decoded.map((json) => PostModel.fromJson(json)).toList());
//         page++;
//       }
//     } else {
//       hasMore = false;
//       print('Failed to load page $page: ${response.statusCode}');
//     }
//   }

//   postList.value = allPosts;
// }
}
