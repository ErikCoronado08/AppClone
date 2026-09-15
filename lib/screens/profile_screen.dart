import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> _profileData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final String response = await rootBundle.loadString('assets/data/beats_data.json');
    final data = json.decode(response);
    setState(() {
      _profileData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFFE50914))),
      );
    }

    final producer = _profileData['producer'];
    final beats = _profileData['beats'] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          producer['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cabecera / Banner simulado de estudio
            Container(
              height: 120,
              color: Colors.grey[900],
              child: const Center(
                child: Icon(Icons.headphones, size: 40, color: Colors.white24),
              ),
            ),
            // Avatar superpuesto
            Transform.translate(
              offset: const Offset(0, -40),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xFFE50914),
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -30),
              child: Column(
                children: [
                  Text(
                    producer['name'],
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    producer['handle'],
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      producer['bio'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${producer['followers']} Followers',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE50914)),
                  ),
                  const SizedBox(height: 16),
                  // Botones de acción
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE50914),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {},
                        child: const Text('Follow'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {},
                        child: const Text('Message'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12),
            // Catálogo del productor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CATALOGUE (${beats.length} Beats)',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: beats.length,
              itemBuilder: (context, index) {
                final beat = beats[index];
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.music_note, color: Colors.white70),
                  ),
                  title: Text(beat['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${beat['genre']} • ${beat['bpm']} BPM', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  trailing: Text('\$${beat['price']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1DB954))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}