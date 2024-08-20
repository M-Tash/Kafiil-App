import 'package:flutter/material.dart';
import 'package:kafiil_test/utils/my_theme.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double smallerDimension =
        screenWidth < screenHeight ? screenWidth : screenHeight;

    double checkboxSize = smallerDimension * 0.045;
    double iconSize = checkboxSize * 0.75;
    double fixedBorderRadius = 3.5;

    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: checkboxSize,
        height: checkboxSize,
        decoration: BoxDecoration(
          color: value ? MyTheme.primary900Color : Colors.transparent,
          border: Border.all(
            color: MyTheme.grey300Color,
            width: smallerDimension * 0.002,
          ),
          borderRadius: BorderRadius.circular(fixedBorderRadius),
        ),
        child: value
            ? Icon(
                Icons.check,
                size: iconSize,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
