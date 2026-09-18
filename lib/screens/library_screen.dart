import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'player_screen.dart';


class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<dynamic> _likedBeats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLikedBeats();
  }

  Future<void> _loadLikedBeats() async {
    try {
      final String response = await rootBundle.loadString('assets/data/beats_data.json');
      final data = json.decode(response);
      setState(() {
        // Simulamos que todos los beats del JSON están en tus "Likes"
        _likedBeats = data['beats'] as List;
        _isLoading = false;
      });
    } catch (e) {
      print("❌ Error cargando el JSON en Library: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MY LIBRARY', style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            indicatorColor: Color(0xFFE50914),
            labelColor: Color(0xFFE50914),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'LIKES'),
              Tab(text: 'PLAYLISTS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pestaña 1: LIKES
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFE50914)))
                : ListView.builder(
                    itemCount: _likedBeats.length,
                    itemBuilder: (context, index) {
                      final beat = _likedBeats[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.music_note, color: Colors.white54),
                        ),
                        title: Text(beat['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(beat['producer'], style: const TextStyle(color: Colors.grey)),
                        trailing: const Icon(Icons.favorite, color: Color(0xFFE50914)),
                        onTap: () {
                          // Abre el reproductor al tocar el beat guardado
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlayerScreen(beat: beat)),
                          );
                        },
                      );
                    },
                  ),
            // Pestaña 2: PLAYLISTS (Simulada vacía)
            const Center(
              child: Text('Tus playlists aparecerán aquí', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}