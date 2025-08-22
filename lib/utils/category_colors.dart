import 'package:flutter/material.dart';

// Centraliza o mapeamento de categorias para cores.
Color categoryColor(String category) {
  final key = category.trim().toLowerCase();
  switch (key) {
    case 'delivery':
      return const Color(0xFFD32F2F); // red 700
    case 'restaurante':
      return const Color(0xFFEF6C00); // deep orange 600
    case 'cafe':
      return const Color(0xFF6D4C41); // brown
    case 'bar':
      return const Color(0xFF8E24AA); // purple
    case 'mercado':
      return const Color(0xFF2E7D32); // green-ish for markets
    case 'outro':
    default:
      return const Color(0xFF616161); // grey 700
  }
}

/// Retorna a mesma cor com alpha especificado (0.0..1.0)
Color categoryColorWithAlpha(String category, double alpha) {
  final base = categoryColor(category);
  final a = (alpha.clamp(0.0, 1.0) * 255).round();
  return base.withAlpha(a);
}
