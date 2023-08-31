import 'package:flutter/material.dart';

class Titles extends StatelessWidget {
  late final String title;
  Titles(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey[900]),
    );
  }
}
// import 'dart:io';

// import 'package:pdf/widgets.dart' as pw;

// Future<void> main() async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text('Hello World!'),
//       ),
//     ),
//   );

//   final file = File('example.pdf');
//   await file.writeAsBytes(await pdf.save());
// }
