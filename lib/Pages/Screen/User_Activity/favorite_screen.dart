import 'package:flutter/material.dart';
import 'package:food_delivery/core/models/on_bording_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final userId = supabase.auth.currentUser?.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Favorites", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body:
          userId == null
              ? Center(child: Text("Please login to view favorites"))
              : StreamBuilder<List<Map<String, dynamic>>>(
                stream: supabase
                    .from("favorites")
                    .stream(primaryKey: ['id'])
                    .eq("user_id", userId)
                    .map((data) => data.cast<Map<String, dynamic>>()),
                builder: (context, index) {
                  return SizedBox();
                },
              ),
    );
  }
}
