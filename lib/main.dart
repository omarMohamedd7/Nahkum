import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/bindings/app_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async{
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const NahkumApp());
}

class NahkumApp extends StatelessWidget {
  const NahkumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      initialBinding: AppBinding(),
      initialRoute: AppPages.INITIAL, // Normal app flow
      getPages: AppPages.routes,
    );
  }
}
