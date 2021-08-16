import 'package:flutter/material.dart';

class TestTextView extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final TextInputType? keyboardtype;
  final Widget? inputIcon;
  final double? elevation;
  final String? hintText;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final Color? cursorColor;
  final double? padding;

  TestTextView({
    Key? key,
    this.textEditingController,
    this.focusNode,
    this.keyboardtype,
    this.inputIcon,
    this.elevation = 1.0,
    this.hintText,
    this.borderSide,
    this.borderRadius,
    this.cursorColor,
    this.padding,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 16.0),
        child: TextField(
          cursorColor: cursorColor ?? Theme.of(context).primaryColor,
          controller: textEditingController,
          focusNode: focusNode,
          keyboardType: keyboardtype,
          decoration: InputDecoration(
            icon: inputIcon,
            hintText: hintText,
          ),
        ),
      ),
      elevation: elevation,
      shape: RoundedRectangleBorder(
        side: borderSide ?? BorderSide.none,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
    );
  }
}
