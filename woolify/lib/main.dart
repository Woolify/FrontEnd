import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woolify/Router/GoRouter.dart';
import 'package:woolify/Theme/ThemeData.dart';

void main() {
  runApp(const ProviderScope(child: Woolify()));
}

myThemeData themeData = myThemeData();
final route = MyGoRouter();

class Woolify extends StatelessWidget {
  const Woolify({super.key});

  @override
  Widget build(context) {
    return MaterialApp.router(
      routeInformationParser: route.router.routeInformationParser,
      routeInformationProvider: route.router.routeInformationProvider,
      routerDelegate: route.router.routerDelegate,
      theme: themeData.lightTheme,
      darkTheme: themeData.darkTheme,
      themeMode: themeData.themeMode,
    );
  }
}
