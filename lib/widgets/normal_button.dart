import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class AppButton extends StatelessWidget {
  final text;
  final Color color;
  final border;
  final textColor;
  final pressed;
  final loading;
  const AppButton(
      {this.text,
      this.border,
      this.textColor,
      this.pressed,
      required this.color,
      this.loading});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 60,
      decoration: border == true
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: color,
              ))
          : BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
            ),
      child: TextButton(
        onPressed: pressed,
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all<Color>(color.withOpacity(0.5)),
          alignment: Alignment.center,
        ),
        child: loading != true
            ? Text(text,
                style: GoogleFonts.getFont(
                  'Roboto',
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ))
            : CircularProgressIndicator(
                color: Palette.caption,
              ),
      ),
    );
  }
}
