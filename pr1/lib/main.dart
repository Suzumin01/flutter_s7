import 'package:flutter/material.dart';
import 'main_navigation.dart';
import 'routes.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/detail_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'info.games',
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (context) => const LoadingPage(),
        Routes.login: (context) => LoginPage(),
        Routes.register: (context) => RegisterPage(),
        Routes.home: (context) => const MainNavigation(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == Routes.detail) {
          final args = settings.arguments as Map<String, dynamic>;
          final item = args['item'] as Map<String, dynamic>;
          final imageIndex = args['imageIndex'] as int;
          return MaterialPageRoute(
            builder: (_) => DetailPage(item: item, imageIndex: imageIndex),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Страница не найдена')),
          ),
        );
      },
    );
  }
}