import 'package:get/get.dart';
import 'package:global_defense_insight/model/news_article.dart';

class NewsController extends GetxController {
  RxList<NewsArticle> topStories = <NewsArticle>[].obs;

  get categoryMap => null;

  @override
  void onInit() {
    super.onInit();
    fetchTopStories();
  }

  void fetchTopStories() async {
    await Future.delayed(Duration(seconds: 1)); // fake delay

    topStories.value = [
      NewsArticle(
        title:
            "Horizon Mid-Life Upgrade Programme Reaches Major Milestone for Italy and France",
        organization: "Global Defense Insight",
        category: "NEWS",
        date: "July 9 , 2027",
        image: "assets/animations/lockhead.jpeg",
      ),
      NewsArticle(
        title: "New Defence Tech Ready for Trials",
        organization: "Global Defense Insight",
        category: "LAND",
        date: "July 9 , 2025",
        image: "assets/animations/lockhead.jpeg",
      ),
      NewsArticle(
        title: " Programme Reaches Major Milestone",
        organization: "Global Defense Insight",
        category: "AeroSpace",
        date: "July 8 , 2025",
        image: "assets/animations/lockhead.jpeg",
      ),
    ];
  }
}
