import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'license_screen.dart';

class PlayerScreen extends StatefulWidget {
  final Map<String, dynamic> beat;

  const PlayerScreen({super.key, required this.beat});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      // Cargamos la URL de audio simulada desde el JSON del beat seleccionado
      await _audioPlayer.setUrl(widget.beat['audio_url']);
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play();
      setState(() => _isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.beat['producer'], style: const TextStyle(fontSize: 14, color: Colors.grey)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Arte de la portada en grande
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))
                ],
              ),
              child: const Center(
                child: Icon(Icons.music_note, size: 100, color: Colors.white54),
              ),
            ),
            const SizedBox(height: 40),
            // Título y Productor
            Text(
              widget.beat['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.beat['producer'],
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            // Controles de Reproducción
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shuffle, size: 24),
                  onPressed: () {},
                ),
                const SizedBox(width: 24),
                IconButton(
                  icon: const Icon(Icons.skip_previous, size: 36),
                  onPressed: () {},
                ),
                const SizedBox(width: 24),
                // Botón principal Play/Pause
                CircleAvatar(
                  radius: 35,
                  backgroundColor: const Color(0xFFE50914),
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                ),
                const SizedBox(width: 24),
                IconButton(
                  icon: const Icon(Icons.skip_next, size: 36),
                  onPressed: () {},
                ),
                const SizedBox(width: 24),
                IconButton(
                  icon: const Icon(Icons.repeat, size: 24),
                  onPressed: () {},
                ),
              ],
            ),
            const Spacer(),
            // Botón de compra rápido simulado con precio que navega a LicenseScreen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50914),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LicenseScreen(beat: widget.beat),
                    ),
                  );
                },
                child: Text(
                  'BUY \$${widget.beat['price']}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}