import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_state.dart';
import 'package:odr_court_app/features/auth/models/login/login_screen.dart';
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
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            locale: appState.locale,
            // ✅ dynamic language comes from AppState
            routes: {
              '/adminDashboard': (_) => const Placeholder(),
              '/claimantDashboard': (_) => const Placeholder(),
            },
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
