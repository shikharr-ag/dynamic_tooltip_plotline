// import 'package:flutter/material.dart';

// import 'my_alphabet_textbox.dart';
// import 'my_number_textbox.dart';
// import 'my_widget_headline.dart';

// import 'my_textbox_template.dart';

// class ColumnChildTextBox extends StatelessWidget {
//   final KeyboardType type;
//   final String headline;

//   final TextEditingController controller;
//   const ColumnChildTextBox(
//       {super.key,
//       required this.type,
//       required this.headline,
//       required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green[100],
//       constraints: const BoxConstraints.expand(),
//       margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
//       padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(child: MyWidgetHeadline(headline: headline)),
//           const SizedBox(height: 4),
//           if (type == KeyboardType.numeral)
//             Expanded(flex: 2, child: MyNumberTextbox(controller: controller)),
//           if (type == KeyboardType.alphabet)
//             Expanded(flex: 2, child: MyAlphabetTextbox(controller: controller)),
//           const SizedBox(height: 4),
//         ],
//       ),
//     );
//   }
// }
