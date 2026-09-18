import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LicenseScreen extends StatefulWidget {
  final Map<String, dynamic> beat;

  const LicenseScreen({super.key, required this.beat});

  @override
  State<LicenseScreen> createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  List<dynamic> _licenses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLicenses();
  }

  Future<void> _loadLicenses() async {
    try {
      final String response = await rootBundle.loadString('assets/data/beats_data.json');
      final data = json.decode(response);
      setState(() {
        _licenses = data['licenses'] as List;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading licenses: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHOOSE YOUR LICENSE', style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFE50914)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabecera con el beat seleccionado
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.music_note, color: Colors.white54, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.beat['title'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(widget.beat['producer'], style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Lista de licencias generadas desde el JSON
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _licenses.length,
                    itemBuilder: (context, index) {
                      final license = _licenses[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(license['type'].toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                            const SizedBox(height: 8),
                            Text('\$${license['price']}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            // Lista de beneficios (features) de la licencia
                            ...((license['features'] as List).map((feature) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.circle, size: 6, color: Colors.grey),
                                    const SizedBox(width: 8),
                                    Text(feature, style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              );
                            })),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE50914),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {
                                  // Simulación de agregar al carrito
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${license['type']} añadida al carrito'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                child: const Text('ADD TO CART'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}