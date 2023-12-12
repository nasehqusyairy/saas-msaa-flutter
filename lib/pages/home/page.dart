import 'package:flutter/material.dart';
import 'package:saas_msaa/pages/home/timelinelist.dart';
import 'package:saas_msaa/pages/profile/page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Kegiatan"),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            const SizedBox(width: 8)
          ],
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: const TimeLineList());
  }
}
