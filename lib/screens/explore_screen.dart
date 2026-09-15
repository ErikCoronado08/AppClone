import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Map<String, dynamic> _beatData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    final String response = await rootBundle.loadString('assets/data/beats_data.json');
    final data = json.decode(response);
    setState(() {
      _beatData = data;
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

    final beats = _beatData['beats'] as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BEATSTARS CLONE',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE50914)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'EXPLORE',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Sección de catálogo en tendencia simulado
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: beats.length,
                itemBuilder: (context, index) {
                  final beat = beats[index];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.music_note, size: 50, color: Colors.white54),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          beat['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '\$${beat['price']} • ${beat['genre']}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'FEATURED PRODUCERS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.person),
              ),
              title: Text(_beatData['producer']['name']),
              subtitle: Text(_beatData['producer']['handle']),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50914),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text('Follow'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}