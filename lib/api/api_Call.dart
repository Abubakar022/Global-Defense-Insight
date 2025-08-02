import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:global_defense_insight/model/category_Model.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'package:http/io_client.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:global_defense_insight/model/category_Model.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'package:http/io_client.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

// class PostController extends GetxController {
//   RxList<PostModel> postList = <PostModel>[].obs;

//   List<PostModel> get topStories => postList.take(4).toList();
//   List<PostModel> get latestNews => postList.skip(4).toList();

//   Map<int, String> categoryMap = {}; // ID → Name

//   // Unsafe client (for development/testing with invalid SSL)
//   IOClient getUnsafeClient() {
//     HttpClient httpClient = HttpClient()
//       ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     return IOClient(httpClient);
//   }

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     await getCategories();
//     await getNewsData();
//   }

//   /// 📦 Load categories from API or cache
//   Future<void> getCategories() async {
//     const cacheKey = "category_data";
//     final addedNames = <String>{};

//     try {
//       final client = getUnsafeClient();
//       final response = await client.get(
//         Uri.parse('https://defensetalks.com/wp-json/wp/v2/categories?per_page=100'),
//       );

//       if (response.statusCode == 200) {
//         final List decoded = jsonDecode(response.body);

//         for (var item in decoded) {
//           final category = CategoryModel.fromJson(item);
//           final name = category.name.trim();
//           if (addedNames.add(name)) {
//             categoryMap[category.id] = name;
//           }
//         }

//         // Save latest categories to cache
//         await APICacheManager().addCacheData(
//           APICacheDBModel(key: cacheKey, syncData: response.body),
//         );
//         return;
//       } else {
//         print('⚠️ API category load failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('⚠️ Error loading categories: $e');
//     }

//     // Try loading from cache if API fails
//     final isCached = await APICacheManager().isAPICacheKeyExist(cacheKey);
//     if (isCached) {
//       final cacheData = await APICacheManager().getCacheData(cacheKey);
//       final List decoded = jsonDecode(cacheData.syncData);

//       for (var item in decoded) {
//         final category = CategoryModel.fromJson(item);
//         final name = category.name.trim();
//         if (addedNames.add(name)) {
//           categoryMap[category.id] = name;
//         }
//       }
//     } else {
//       print("❌ No cached categories available.");
//     }
//   }

//   /// 📰 Load news posts from API or cache
//   Future<void> getNewsData() async {
//     const cacheKey = "news_data";

//     try {
//       final client = getUnsafeClient();
//       final response = await client.get(
//         Uri.parse('https://defensetalks.com/wp-json/wp/v2/posts?per_page=30'),
//       );

//       if (response.statusCode == 200) {
//         final List decoded = jsonDecode(response.body);
//         postList.value = decoded.map((json) => PostModel.fromJson(json)).toList();

//         // Save latest posts to cache
//         await APICacheManager().addCacheData(
//           APICacheDBModel(key: cacheKey, syncData: response.body),
//         );
//         return;
//       } else {
//         print('⚠️ API post load failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       print("⚠️ Error loading posts: $e");
//     }

//     // Try loading from cache if API fails
//     final isCached = await APICacheManager().isAPICacheKeyExist(cacheKey);
//     if (isCached) {
//       final cacheData = await APICacheManager().getCacheData(cacheKey);
//       final List decoded = jsonDecode(cacheData.syncData);
//       postList.value = decoded.map((json) => PostModel.fromJson(json)).toList();
//     } else {
//       print("❌ No cached posts available.");
//     }
//   }
// }

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


}
