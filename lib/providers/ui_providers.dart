import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Persist selected year and month for UI across screens.
final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);
final selectedMonthProvider = StateProvider<int>((ref) => DateTime.now().month);
