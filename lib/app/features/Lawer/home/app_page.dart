import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/bindings/home_binding.dart';
import 'presentation/views/home_view.dart';

class LawyerHomePage extends StatelessWidget {
  const LawyerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lawyer Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: LawyerHomeBinding(),
      home: const HomeView(),
    );
  }
}
