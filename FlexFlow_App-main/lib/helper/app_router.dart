import 'package:flutter/material.dart';
import '../Presentation/Screens/chat_screen.dart';
import '../Presentation/Screens/home_screen.dart';
import 'package:flex_flow_app/Presentation/Screens/intro_screen.dart';
import 'package:flex_flow_app/Presentation/Screens/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/chat':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/intro':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
