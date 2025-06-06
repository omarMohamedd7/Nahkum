import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/controllers/cases_binding.dart';
import 'presentation/views/my_cases_view.dart';

class LawyerCasesPage extends StatelessWidget {
  const LawyerCasesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the binding to ensure the controller is available
    CasesBinding().dependencies();

    return const GetMaterialApp(
      title: 'Lawyer Cases',
      debugShowCheckedModeBanner: false,
      home: MyCasesView(),
    );
  }
}
