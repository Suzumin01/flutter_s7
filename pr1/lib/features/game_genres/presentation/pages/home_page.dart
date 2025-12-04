import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../../../../routes.dart';
import '../bloc/game_genre_bloc.dart';
import '../../../../models/game_genre.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateToDetail(BuildContext context, GameGenreModel genre) {
    Navigator.pushNamed(
      context,
      Routes.detail,
      arguments: {
        'item': genre.toMap(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double platformPadding =
    (kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows)
        ? 50
        : 20;
    final double verticalSpacing =
    (MediaQuery.of(context).size.width > 600) ? 20 : 10;

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

      body: BlocBuilder<GameGenreBloc, GameGenreState>(
        builder: (context, state) {
          final List<String> galleryImages =
          (state is GameGenreLoaded)
              ? state.gameGenres.map((g) => g.imagePath).toList()
              : [
            'assets/images/1.jpg',
            'assets/images/2.jpg',
            'assets/images/3.jpg',
            'assets/images/4.jpg',
            'assets/images/5.jpeg',
          ];

          return SingleChildScrollView(
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
                      itemCount: galleryImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: verticalSpacing),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              galleryImages[index],
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

                  if (state is GameGenreInitial) ...[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sports_esports,
                              size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 20),
                          const Text(
                            'Жанры игр не загружены',
                            style:
                            TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<GameGenreBloc>()
                                  .add(LoadGameGenresEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: const Text(
                              'Загрузить жанры игр',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (state is GameGenreLoading) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else if (state is GameGenreError) ...[
                    Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ] else if (state is GameGenreLoaded) ...[
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
                          final bool isWideScreen =
                              constraints.maxWidth > 600;

                          if (isWideScreen) {
                            return GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: verticalSpacing,
                                mainAxisSpacing: verticalSpacing,
                                childAspectRatio: 3 / 1,
                              ),
                              itemCount: state.gameGenres.length,
                              itemBuilder: (context, index) {
                                final genre = state.gameGenres[index];
                                return Card(
                                  elevation: 3,
                                  margin: EdgeInsets.zero,
                                  child: ListTile(
                                    leading: const Icon(Icons.games,
                                        color: Colors.blue),
                                    title: Text(genre.title),
                                    subtitle: Text(genre.description),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                    onTap: () =>
                                        _navigateToDetail(context, genre),
                                  ),
                                );
                              },
                            );
                          } else {
                            return ListView.builder(
                              itemCount: state.gameGenres.length,
                              itemBuilder: (context, index) {
                                final genre = state.gameGenres[index];
                                return Card(
                                  margin: EdgeInsets.only(
                                      bottom: verticalSpacing),
                                  elevation: 3,
                                  child: ListTile(
                                    leading: const Icon(Icons.games,
                                        color: Colors.blue),
                                    title: Text(genre.title),
                                    subtitle: Text(genre.description),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                    onTap: () =>
                                        _navigateToDetail(context, genre),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],

                  const Divider(),
                  SizedBox(height: verticalSpacing),

                  Row(
                    children: [
                      Image.network(
                        'https://img.icons8.com/?size=100&id=15263&format=png&color=000000',
                        width: 40,
                        height: 40,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.person),
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
          );
        },
      ),
    );
  }
}
