// Add the flutter Riverpod package for state management
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final favoriteProvider = ChangeNotifierProvider<FavoriteProvider>(
  (ref) => FavoriteProvider(),
);

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  List<String> get favorite => _favoriteIds;
  String? get userId => _supabaseClient.auth.currentUser?.id;
  FavoriteProvider() {
    // Load the favorite providers
    loadFavorites();
  }
  void reset() {
    _favoriteIds = [];
    notifyListeners();
  }

  // Toggle favorite state
  Future<void> toggleFavorite(String productId) async {
    if (_favoriteIds.contains(productId)) {
      // Remove from favorites
      _favoriteIds.remove(productId);
      await _removeFavorite(productId);
    } else {
      // Add to favorites
      _favoriteIds.add(productId);
      await _addFavorite(productId);
    }
    notifyListeners();
  }

  // Check if a product is in favorites
  bool isExist(String productId) {
    return _favoriteIds.contains(productId);
  }

  // Add favorite to supabase
  Future<void> _addFavorite(String productId) async {
    if (userId == null) return;
    try {
      // check in database
      await _supabaseClient.from("favorites").insert({
        "user_id": userId,
        "product_id": productId,
      });
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  // Remove favorite from supabase database
  Future<void> _removeFavorite(String productId) async {
    if (userId == null) return;
    try {
      // check in database
      await _supabaseClient.from("favorites").delete().match({
        "user_id": userId!,
        "product_id": productId,
      });
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  // Load favorites from supabase
  Future<void> loadFavorites() async {
    if (userId == null) return;
    try {
      final data = await _supabaseClient
          .from("favorites")
          .select("product_id")
          .eq("user_id", userId!);
      _favoriteIds =
          data.map<String>((row) => row['product_id'] as String).toList();
    } catch (e) {
      print("Error loading favorites: $e");
    }
    notifyListeners();
  }
}
