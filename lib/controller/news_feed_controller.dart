import 'package:get/get.dart';
import '../models/news_article_model.dart';
import '../repository/user_repository.dart/user_repository.dart';

class NewsFeedController extends GetxController {
  final UserRepository userRepository = UserRepository.instance;

  var articles = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() async {
    try {
      isLoading.value = true;
      final stream = userRepository.getArticles();
      stream.listen((data) {
        articles.value = data;
        hasError.value = false;
      }, onError: (error) {
        hasError.value = true;
      });
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    userRepository.logout();
  }
}
