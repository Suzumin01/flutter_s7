import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> gameGenres = [
    {
      'title': 'Action',
      'description': 'Динамичные игры с акцентом на физическое взаимодействие'
    },
    {
      'title': 'Action-adventure',
      'description': 'Комбинация экшена и приключенческих элементов'
    },
    {
      'title': 'Adventure',
      'description': 'Игры с упором на исследование и решение загадок'
    },
    {
      'title': 'Puzzle',
      'description': 'Игры-головоломки, требующие логического мышления'
    },
    {
      'title': 'Role-playing',
      'description': 'Игры с развитием персонажа и глубоким сюжетом'
    },
  ];

  final List<String> _imagePaths = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpeg',
  ];

  void _navigateToDetail(BuildContext context, Map<String, String> genre, int index) {
    Navigator.pushNamed(
        context,
        Routes.detail,
        arguments: {
          'item': genre,
          'imageIndex': index,
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final double platformPadding = (kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows) ? 50 : 20;
    final double verticalSpacing = (MediaQuery.of(context).size.width > 600) ? 20 : 10;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://img.icons8.com/?size=100&id=119900&format=png&color=000000',
              width: 40,
              height: 40,
              errorBuilder: (_, __, ___) => const Icon(Icons.gamepad),
            ),
            const SizedBox(width: 10),
            const Text(
              'info.games',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Oblivion',
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(platformPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: platformPadding),
              const Text(
                'Виды компьютерных игр',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: verticalSpacing),
              const Text(
                'Окунитесь в цифровые миры с головой вместе с нашим приложением. '
                    'Наша задача - найти именно то, что вам нужно.',
                style: TextStyle(fontSize: 16),
              ),
              const Divider(),
              SizedBox(height: platformPadding),

              const Row(
                children: [
                  Icon(Icons.image, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    'Галерея игровых жанров',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: verticalSpacing),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imagePaths.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: verticalSpacing),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          _imagePaths[index],
                          width: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error, size: 40),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: platformPadding),
              const Divider(),
              SizedBox(height: verticalSpacing),

              const Row(
                children: [
                  Icon(Icons.list, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    'Список жанров',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: verticalSpacing),

              SizedBox(
                height: 400,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isWideScreen = constraints.maxWidth > 600;

                    if (isWideScreen) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: verticalSpacing,
                          mainAxisSpacing: verticalSpacing,
                          childAspectRatio: 3 / 1,
                        ),
                        itemCount: gameGenres.length,
                        itemBuilder: (context, index) {
                          final genre = gameGenres[index];
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              leading: const Icon(Icons.games, color: Colors.blue),
                              title: Text(genre['title']!),
                              subtitle: Text(genre['description']!),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                              onTap: () => _navigateToDetail(context, genre, index),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: gameGenres.length,
                        itemBuilder: (context, index) {
                          final genre = gameGenres[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: verticalSpacing),
                            elevation: 3,
                            child: ListTile(
                              leading: const Icon(Icons.games, color: Colors.blue),
                              title: Text(genre['title']!),
                              subtitle: Text(genre['description']!),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                              onTap: () => _navigateToDetail(context, genre, index),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),

              const Divider(),
              SizedBox(height: verticalSpacing),
              Row(
                children: [
                  Image.network(
                    'https://img.icons8.com/?size=100&id=15263&format=png&color=000000',
                    width: 40,
                    height: 40,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person),
                  ),
                  SizedBox(width: verticalSpacing),
                  const Expanded(
                    child: Text(
                      'Смольников Никита Сергеевич ИКБО-35-22',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: platformPadding),
            ],
          ),
        ),
      ),
    );
  }
}