import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/login_screen.dart';
import 'package:odr_court_app/features/auth/models/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const OdrApp());
}

class OdrApp extends StatelessWidget {
  const OdrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        routes: {
          '/adminDashboard': (_) => const Placeholder(),
          '/claimantDashboard': (_) => const Placeholder(),
        },
        home: LoginScreen(),
      ),
    );
  }
}
