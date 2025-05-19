import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/Auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  // sign up method
  // ignore: body_might_complete_normally_nullable
  Future<String?> signup(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return null; // indicate success
      }
      return "An error occurred";
    } on AuthException catch (e) {
      return e.message; // return error message
    } catch (e) {
      print("Error signing up: $e");
    }
  }

  // sign in method
  Future<String?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return null; // indicate success
      }
      return "Invalid credentials";
    } on AuthException catch (e) {
      return e.message; // return error message
    } catch (e) {
      print("Error signing up: $e");
    }
  }

  // sign out method
  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
