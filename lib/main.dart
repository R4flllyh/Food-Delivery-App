import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/Pages/Auth/login_screen.dart';
import 'package:food_delivery/Pages/Screen/app_main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://hmrgfzqfrusxsazqcdik.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhtcmdmenFmcnVzeHNhenFjZGlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDczOTEzOTIsImV4cCI6MjA2Mjk2NzM5Mn0.pZ4xR9BESyfWgl4y_KxYYUPc-JA9l2RAZePQ_5YJujY',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Initialize the riverpod_flutter
    return ProviderScope(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: AuthCheck()),
    );
  }
}

class AuthCheck extends StatelessWidget {
  final supabase = Supabase.instance.client;
  AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) {
          return AppMainScreen(); // if logged in, go to homepage
        } else {
          return LoginScreen(); // otherwise, go to login page
        }
      },
    );
  }
}
