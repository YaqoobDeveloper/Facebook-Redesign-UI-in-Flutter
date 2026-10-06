import 'package:flutter/material.dart';

import 'screens/feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yaqoob Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        // One font for the whole app.
        fontFamily: 'Poppins',
      ),
      home: const FeedScreen(),
    );
  }
}
