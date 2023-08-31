import 'package:flutter/material.dart';


class PopUpMenuItemWidget extends StatelessWidget {
  const PopUpMenuItemWidget({
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black54,
            size: 18,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
  
}
