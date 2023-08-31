import 'package:flutter/material.dart';
import 'package:lamit/widget/appcolor.dart';

class CustomText extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? type;
  final bool? error;
  final double? height;
  final bool? isBG;
  final onChanged;
  final Color? textColor;

  const CustomText(
      {super.key,
      this.hint,
      required this.controller,
      this.obscureText,
      this.type,
      this.error,
      this.height,
      this.isBG,
      this.onChanged,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == null ? 50 : height,
      decoration: BoxDecoration(
          //border: Border.all(color: AppColors.primaryColor, width: 2),
          color: isBG == null
              ? AppColors.primaryColor
              : AppColors.primaryColor[50],
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: [
            //   if (hint == AppUrls.currency)
            Text(
              "kjjkjkkj",
              //  AppUrls.currency,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: textColor == null ? Colors.black : textColor),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText == null ? false : obscureText!,
                keyboardType: type == null ? TextInputType.text : type,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: textColor == null ? Colors.black : textColor,
                  //  fontSize: hint == AppUrls.currency ? 26 : null,
                  //fontWeight:
                  // hint == AppUrls.currency ? FontWeight.w600 : null
                ),
                decoration: InputDecoration(
                  prefixIcon: error == null
                      ? null
                      : error!
                          ? Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            )
                          : null,
                  border: InputBorder.none,
                  // hintText: hint == null
                  //     ? ''
                  //     : hint == AppUrls.currency
                  //         ? ''
                  //         : hint,
                  // hintStyle: TextStyle(
                  //     color: textColor == null
                  //         ? AppColors.accentColor
                  //         : textColor)
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
