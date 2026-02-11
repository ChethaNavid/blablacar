import 'package:blablacar/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? buttonIcon;
  final String buttonText;
  final bool isPrimaryColor;

  const BlaButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonIcon,
    required this.isPrimaryColor,
  });

  Color get buttonColor =>
      isPrimaryColor ? BlaColors.backGroundColor : BlaColors.white;

  Color get textColor {
    if (buttonColor == BlaColors.backGroundColor) {
      return BlaColors.white;
    } else {
      return BlaColors.backGroundColor;
    }
  }

  BorderSide get border => isPrimaryColor ? BorderSide.none : BorderSide(color: BlaColors.disabled, width: 1);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: border,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      foregroundColor: textColor,
      alignment: Alignment.center,
    );

    if (buttonIcon != null) {
      return ElevatedButton.icon(
        style: style,
        onPressed: onPressed,
        icon: Icon(buttonIcon),
        label: Text(buttonText),
      );
    }

    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: Text(buttonText, style: BlaTextStyles.button),
    );
  }
}
