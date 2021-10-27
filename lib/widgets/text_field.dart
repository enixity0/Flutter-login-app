import 'package:flutter/material.dart';

import '../colors.dart';

class CTextField extends StatelessWidget {
  final placeholder;
  final icon;
  final controller;
  final error;
  final type;
  final onChange;
  final onSubmit;
  const CTextField(
      {Key? key,
      this.placeholder,
      this.icon,
      this.controller,
      this.error,
      this.type,
      this.onChange,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: error != "" ? Palette.accent : Palette.main,
              ),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: size.width - 115,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    controller: controller,
                    cursorColor: Palette.title,
                    onSubmitted: onSubmit,
                    decoration: InputDecoration(
                      hintText: placeholder,
                      hintStyle: TextStyle(
                          color: Palette.caption,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 1.5),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Icon(
                    icon,
                    color: error == "" ? Palette.main : Palette.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
        error != ""
            ? Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  error,
                  style: TextStyle(
                    color: Palette.accent,
                  ),
                ),
              )
            : Container(margin: EdgeInsets.only(bottom: 10)),
      ],
    );
  }
}
