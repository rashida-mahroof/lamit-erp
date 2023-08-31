import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final IconData? iconData;
  final bool? isPassword;
  final TextInputType? type;
  final TextEditingController controller;

  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.iconData,
      this.isPassword,
      required this.type,
      required this.controller})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16),
                child: widget.iconData == null
                    ? Container()
                    : Icon(
                        widget.iconData,
                        color: Colors.grey,
                      ),
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText:
                      widget.isPassword == null ? false : widget.isPassword!,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: widget.hint),
                  keyboardType: widget.type,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
