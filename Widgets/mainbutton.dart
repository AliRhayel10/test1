import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    this.func,
    required this.width,
    required this.height,
    required this.borderColor,
    this.Icons,
    required this.fontSize,
  });
  final IconData? Icons;
  final String text;
  final double width;
  final double height;
  final Color textColor;
  final Color borderColor;
  final Color buttonColor;
  final double fontSize;
  final Function? func;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: () => {func!()},
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: height, //30
              width: width, //110
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
