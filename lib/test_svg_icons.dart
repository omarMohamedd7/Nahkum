// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:legal_app/app/core/utils/app_assets.dart';
//
// class TestSvgIcons extends StatelessWidget {
//   const TestSvgIcons({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test SVG Icons'),
//       ),
//       body: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Active Icons',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 16),
//                 _buildIconRow([
//                   AppAssets.activeHome,
//                   AppAssets.activeMessage,
//                   AppAssets.activeJudge,
//                   AppAssets.activeFolderOpen,
//                   AppAssets.activeSetting,
//                 ]),
//                 const SizedBox(height: 32),
//                 const Text('Unactive Icons',
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 16),
//                 _buildIconRow([
//                   AppAssets.unactiveHome,
//                   AppAssets.unactiveMessage,
//                   AppAssets.unactiveJudge,
//                   AppAssets.unactiveFolderOpen,
//                   AppAssets.unactiveSetting,
//                 ]),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIconRow(List<String> icons) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         for (final iconPath in icons)
//           Column(
//             children: [
//               SvgPicture.asset(
//                 iconPath,
//                 width: 30,
//                 height: 30,
//                 placeholderBuilder: (context) => Container(
//                   width: 30,
//                   height: 30,
//                   color: Colors.red,
//                   child: const Icon(Icons.error, size: 15, color: Colors.white),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(iconPath.split('/').last),
//             ],
//           ),
//       ],
//     );
//   }
// }
