import 'package:flutter_assignment/auth_middleware.dart';
import 'package:flutter_assignment/repository/user_repository.dart/message.dart';
import 'package:flutter_assignment/screens/add_article_screen.dart';
import 'package:flutter_assignment/screens/login_screen.dart';
import 'package:flutter_assignment/screens/news_feed_screen.dart';
import 'package:flutter_assignment/screens/registration_screen.dart';
import 'package:get/get.dart';

import '../auth_wrapper.dart';
import 'routing_name.dart';

class RoutePages {
  static List<GetPage> pages = [
    GetPage(
      name: RoutingNames.authWrapper,
      page: () => const AuthWrapper(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutingNames.login,
      page: () => LoginScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutingNames.registration,
      page: () => RegistrationScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutingNames.newsFeed,
      page: () => NewsFeed(),
      middlewares: [AuthMiddleware()],
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutingNames.addArticle,
      middlewares: [AuthMiddleware()],
      page: () => AddArticleScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutingNames.message,
      page: () => const Message(),
      transition: Transition.fade,
    ),
  ];
}
