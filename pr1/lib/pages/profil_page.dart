import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Смольников Никита Сергеевич',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'ИКБО-35-22',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Настройки'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text('История просмотров'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Выйти'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}