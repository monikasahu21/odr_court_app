import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_state.dart';
import 'package:odr_court_app/features/auth/models/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Firebase setup
  runApp(const OdrApp());
}

class OdrApp extends StatelessWidget {
  const OdrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/adminDashboard': (_) => const Placeholder(),
          '/claimantDashboard': (_) => const Placeholder(),
        },
        home: LoginScreen(),
      ),
    );
  }
}
