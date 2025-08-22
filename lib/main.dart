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
        // Use a red-based seeded ColorScheme for Material 3
        colorSchemeSeed: Colors.red,
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700),
          titleMedium: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600),
          bodyMedium: GoogleFonts.dmSans(fontSize: 14),
        ),
  // Cards will use defaults from the ColorScheme; custom card shape handled per-widget if needed
        // Elevated buttons with solid red background and rounded corners
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
        // Text buttons and outlined buttons use red accents
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.red.shade600),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red.shade600, side: BorderSide(color: Colors.red.shade200)),
        ),
        // Floating action button theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        // Chip theme for category chips
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey.shade100,
          labelStyle: const TextStyle(fontSize: 12),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
  // Card defaults are handled per-widget to avoid SDK compatibility issues
        // Bottom sheets (like the save-location sheet in the mock) should have rounded top corners
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
