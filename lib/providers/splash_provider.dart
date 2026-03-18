import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = FutureProvider<void>((ref) async {
  // Simulate a delay for the splash screen (e.g., 3 seconds)
  await Future.delayed(const Duration(seconds: 3));
  // You can add other initialization logic here (e.g., checking auth state)
});
