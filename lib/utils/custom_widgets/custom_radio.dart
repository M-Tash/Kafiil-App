import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final String title;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.activeBorderColor,
    required this.inactiveBorderColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double iconSize = isPortrait ? screenHeight * 0.025 : screenHeight * 0.08;
    double spacing = isPortrait ? screenWidth * 0.050 : screenWidth * 0.030;

    return Padding(
      padding: EdgeInsets.only(right: spacing),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: spacing * 0.5),
            child: GestureDetector(
              onTap: () {
                onChanged(value);
              },
              child: Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: iconSize,
                color: isSelected ? activeBorderColor : inactiveBorderColor,
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!.copyWith(
                fontSize:
                    isPortrait ? screenHeight * 0.018 : screenHeight * 0.045,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
