
import 'package:my_rick_and_morty/core/routing/routes.dart';

import 'package:flutter/material.dart';
import 'package:my_rick_and_morty/features/charchter_details_screen/screens/character_detail_screen.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/screen/home_screen.dart';

import '../../features/splash_screen/splac_screen.dart';
import 'platform_page_route.dart';
import 'undefined_route_screen.dart';

class RouteGenerator {
  static Route generateBaseRoute(RouteSettings settings) {
    return getRoute(settings);
  }

  static Route getRoute(RouteSettings settings) {
    if (settings.name == Routes.init) {
      return platformPageRoute(const SplashScreen());
    }
    if (settings.name == Routes.home) {
      return platformPageRoute(const HomeScreen());
    }
    if (settings.name == Routes.characterDetails) {
      final args = settings.arguments as Map<String, dynamic>;
      return platformPageRoute( CharacterDetailScreen(characterModel: args['characterModel'],));
    }
    
     else {
      return platformPageRoute(UndefinedRouteScreen(settings.name));
    }

    // return platformPageRoute(UndefinedRouteScreen(settings.name));
  }
}
