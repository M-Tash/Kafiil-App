import 'package:flutter/material.dart';
import 'package:kafiil_test/utils/my_theme.dart';

class CustomRowCheckBox extends StatefulWidget {
  final String icon;
  final String title;
  bool isChecked;
  final bool readonly;
  final ValueChanged<bool>? onChanged;

  CustomRowCheckBox({
    super.key,
    required this.icon,
    required this.title,
    this.isChecked = false,
    this.readonly = false,
    this.onChanged,
  });

  @override
  State<CustomRowCheckBox> createState() => _CustomRowCheckBoxState();
}

class _CustomRowCheckBoxState extends State<CustomRowCheckBox> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double checkboxSize =
        isPortrait ? screenHeight * 0.02 : screenHeight * 0.05;
    double iconSize = isPortrait ? checkboxSize * 1.125 : checkboxSize * 1.8;
    double spacing = isPortrait ? screenWidth * 0.04 : screenWidth * 0.03;
    double borderRadius = isPortrait ? 4.0 : 4.0;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.009),
      child: Row(
        children: [
          SizedBox(
            height: checkboxSize,
            width: checkboxSize,
            child: GestureDetector(
              onTap: widget.readonly
                  ? null
                  : () {
                      setState(() {
                        widget.isChecked = !widget.isChecked;
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget.isChecked);
                        }
                      });
                    },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: widget.isChecked
                        ? MyTheme.primary900Color
                        : MyTheme.grey300Color,
                    width: screenWidth * 0.004,
                  ),
                  color: widget.isChecked
                      ? MyTheme.primary900Color
                      : Colors.transparent,
                ),
                child: widget.isChecked
                    ? Center(
                        child: Icon(
                          Icons.check,
                          size: checkboxSize * 0.72,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(width: spacing),
          Image.asset(
            widget.icon,
            width: iconSize,
            height: iconSize,
          ),
          SizedBox(width: spacing * 0.67),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: isPortrait
                      ? screenHeight * 0.02 : screenHeight * 0.043,
                ),
          ),
        ],
      ),
    );
  }
}
