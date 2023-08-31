import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;

  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     // gradient: LinearGradient(
      //     //     end: Alignment.topCenter,
      //     //     begin: Alignment.bottomCenter,
      //       //  colors:Colors.grey[200],
      child: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#F9F9F9"),
        leadingWidth: 40,
        titleSpacing: 0,
        title: Text(
          title!,
          style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 2, 76, 142),
              fontWeight: FontWeight.bold),
        ),

        // Text(title!),
        actions: actions == null ? [] : actions,
      ),
    );
  }
}
