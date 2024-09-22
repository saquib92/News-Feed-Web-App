import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'repository/user_repository.dart/user_repository.dart';
import 'routes/routing_name.dart';

class AuthMiddleware extends GetMiddleware {
  final UserRepository userRepository = UserRepository.instance;

  @override
  RouteSettings? redirect(String? route) {
    if (!userRepository.isLoggedInSync()) {
      return RouteSettings(name: RoutingNames.login);
    }
    return null;
  }
}
