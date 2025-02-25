import 'package:flutter/material.dart';
import 'package:flutter_ronanii/theme/theme.dart';

import 'screens/ride_pref/ride_pref_screen.dart';
// import 'lib/screens/ride_pref/ride_pref_screen.dart';
// import 'lib/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}
