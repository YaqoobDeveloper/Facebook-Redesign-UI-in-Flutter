import 'package:flutter/material.dart';

/// All app colors live here. Change a value once and it updates everywhere.
abstract final class AppColors {
  static const page = Color(0xFF171B26); // screen background
  static const card = Color(0xFF1F2432); // post cards
  static const navBar = Color(0xFF1C2130); // bottom navigation bar
  static const navBorder = Color(0xFF262C3B);
  static const placeholder = Color(0xFF3A4152); // empty avatar / image

  static const blue = Color(0xFF2F7BFF); // active tab, compose button
  static const heart = Color(0xFFE5484D); // like button

  static const text = Colors.white; // titles
  static const body = Color(0xFFDADDE5); // normal text
  static const muted = Color(0xFF8A90A2); // secondary text
}
