import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/utils/app_router.dart';
import 'core/widgets/splash_screen.dart';
import 'features/auth/presentation/views/login_screen.dart';
import 'features/profile/data/providers/user_profile_provider.dart';

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: const NahkumApp(),
    ),
  );
}

class NahkumApp extends StatelessWidget {
  const NahkumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nahkum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC8A45D), // Gold color from logo
          primary: const Color(0xFFC8A45D),
          background: const Color(0xFF181E3C), // Dark blue background
        ),
        useMaterial3: true,
        fontFamily: 'Almarai',
      ),
      // Set up the router
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(
              nextScreen: const LoginScreen(),
            ),
      },
      // Uncomment to bypass splash and go directly to login screen when needed
      // home: const LoginScreen(),
    );
  }
}
