import 'package:flutter/material.dart';
import '../models/crop.dart';
import '../services/firestore_service.dart';
import '../widgets/crop_card.dart';
import 'place_order.dart';

class SearchCrops extends StatefulWidget {
  const SearchCrops({super.key});

  @override
  State<SearchCrops> createState() => _SearchCropsState();
}

class _SearchCropsState extends State<SearchCrops>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final firestore = FirestoreService();

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _fade = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Crops"),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: StreamBuilder<List<Crop>>(
              stream: firestore.getCrops(),
              builder: (context, snapshot) {

                // ⏳ LOADING
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                final crops = snapshot.data!;

                // ❌ EMPTY STATE
                if (crops.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Crops Found 😔",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                // 📦 LIST
                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: crops.length,
                  itemBuilder: (context, index) {
                    final crop = crops[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        child: CropCard(
                          crop: crop,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlaceOrder(crop: crop),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}