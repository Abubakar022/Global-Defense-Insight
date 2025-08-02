import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

const fetchNewPostsTask = "fetchNewPostsTask";
const lastPostIdKey = 'last_post_id';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == fetchNewPostsTask) {
      const url = "https://defensetalks.com/wp-json/wp/v2/posts";

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final List data = json.decode(response.body);

          final prefs = await SharedPreferences.getInstance();
          final lastPostId = prefs.getInt(lastPostIdKey) ?? 0;

          final latestPost = data.first;
          final int currentPostId = latestPost['id'];

          if (currentPostId != lastPostId) {
            prefs.setInt(lastPostIdKey, currentPostId);

            final title = latestPost['title']['rendered'];
            final postLink = latestPost['link'];

            // Show notification
            await flutterLocalNotificationsPlugin.show(
              0,
              "New Post: $title",
              "Tap to read more...",
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'new_post_channel',
                  'New Post Notifications',
                  importance: Importance.max,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
              payload: postLink,
            );
          }
        }
      } catch (e) {
        print("Error fetching posts: $e");
      }
    }

    return Future.value(true);
  });
}
