import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart'; // ✅ for AppThemes
import 'package:odr_court_app/features/auth/Reusable_Widget/app_state.dart';
import 'package:odr_court_app/features/auth/models/login/login_screen.dart';
import 'package:odr_court_app/features/auth/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Load saved app settings (language + dark mode)
  final appState = AppState();
  await appState.initializeAppSettings();

  runApp(OdrApp(appState: appState));
}

class OdrApp extends StatelessWidget {
  final AppState appState;

  const OdrApp({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState), // ✅ keep same instance
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            name: "Guest User",
            role: "Claimant",
            email: "guest@example.com",
          ),
        ),
      ],
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            // ✅ Localization
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            locale: appState.locale,

            // ✅ App-wide theme switching
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            // ✅ Routes
            routes: {
              '/adminDashboard': (_) => const Placeholder(),
              '/claimantDashboard': (_) => const Placeholder(),
            },

            // ✅ Default screen
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
