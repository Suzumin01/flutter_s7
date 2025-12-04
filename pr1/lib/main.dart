import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/game_genres/presentation/pages/detail_page.dart';
import 'main_navigation.dart';
import 'routes.dart';
import 'features/game_genres/presentation/pages/loading_page.dart';
import 'features/game_genres/presentation/pages/login_page.dart';
import 'features/game_genres/presentation/pages/register_page.dart';
import 'features/game_genres/presentation/bloc/game_genre_bloc.dart';
import 'di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(const MyApp());
}

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
        Routes.home: (context) => BlocProvider(
          // create: (_) => getIt<GameGenreBloc>()..add(LoadGameGenresEvent()),
          create: (_) => getIt<GameGenreBloc>(),
          child: const MainNavigation(),
        ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == Routes.detail) {
          final args = settings.arguments as Map<String, dynamic>;
          final item = args['item'] as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => DetailPage(item: item),
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
