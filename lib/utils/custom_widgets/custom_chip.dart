import 'package:flutter/material.dart';
import 'package:kafiil_test/utils/my_theme.dart';

class ItemChip extends StatefulWidget {
  ItemChip({
    Key? key,
    required this.textEditingController,
    required this.values,
    this.readonly = false,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final List<String> values;
  final bool readonly;

  @override
  State<ItemChip> createState() => _ItemChipState();
}

class _ItemChipState extends State<ItemChip> {
  _onDelete(index) {
    if (!widget.readonly) {
      setState(() {
        widget.values.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double containerWidth = isPortrait ? screenWidth * 0.9 : screenWidth * 0.8;
    double minContainerHeight =
        isPortrait ? screenHeight * 0.12 : screenHeight * 0.1;
    double fixedBorderRadius = isPortrait ? 16.0 : 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: containerWidth,
          constraints: BoxConstraints(minHeight: minContainerHeight),
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.0075),
          decoration: BoxDecoration(
            color: MyTheme.grey50Color,
            borderRadius: BorderRadius.circular(fixedBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.015,
                    top: screenHeight * 0.02,
                    right: screenWidth * 0.012),
                child: Wrap(
                  spacing: screenWidth * 0.005,
                  runSpacing: screenHeight * 0.005,
                  children: List.generate(
                    widget.values.length,
                    (index) => _Chip(
                      label: widget.values[index],
                      onDeleted: _onDelete,
                      index: index,
                      readonly: widget.readonly,
                    ),
                  ),
                ),
              ),
              TextFormField(
                readOnly: widget.readonly,
                onFieldSubmitted: (value) {
                  if (!widget.readonly) {
                    setState(() {
                      widget.values.add(value);
                      widget.textEditingController.clear();
                    });
                  }
                },
                controller: widget.textEditingController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(fixedBorderRadius),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(fixedBorderRadius),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: MyTheme.grey50Color,
                  contentPadding: EdgeInsets.only(
                    left: screenWidth * 0.04,
                    top: screenHeight * 0.012,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
    required this.readonly,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double chipFontSize =
        isPortrait ? screenHeight * 0.017 : screenHeight * 0.05;
    double deleteIconSize =
        isPortrait ? screenHeight * 0.02 : screenHeight * 0.018;
    double chipBorderRadius =
        isPortrait ? screenWidth * 0.025 : screenWidth * 0.02;

    return Chip(
      side: BorderSide.none,
      backgroundColor: const Color(0xffEAFFF5),
      labelStyle: TextStyle(fontSize: chipFontSize, color: Colors.white),
      elevation: 0,
      labelPadding: EdgeInsets.only(left: screenWidth * 0.02),
      label: Text(
        label,
        style: TextStyle(
          color: const Color(0xff1DBF73),
          fontSize: chipFontSize,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(chipBorderRadius),
      ),
      deleteIcon: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.01),
        child: Icon(
          Icons.close,
          size: deleteIconSize,
          color: const Color(0xff1DBF73),
        ),
      ),
      onDeleted: readonly ? null : () => onDeleted(index),
    );
  }
}
