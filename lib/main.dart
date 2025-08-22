import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: FoodTrackerApp()));
}

class FoodTrackerApp extends StatelessWidget {
  const FoodTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700),
          titleMedium: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600),
          bodyMedium: GoogleFonts.dmSans(fontSize: 14),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
