import 'package:flutter/material.dart';
import 'package:kafiil_test/utils/my_theme.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait = screenHeight > screenWidth;

    final double buttonSize =
        isPortrait ? screenWidth * 0.08 : screenHeight * 0.105;
    final double iconSize = buttonSize * 0.5;
    final double iconSize2 = buttonSize * 0.35;
    final double borderWidth = buttonSize * 0.05;
    final double borderRadius = buttonSize * 0.2;
    final double horizontalPadding =
        isPortrait ? buttonSize * 0.15 : buttonSize * 0.30;
    final double verticalPadding = buttonSize * 0.25;
    final double fontSize = buttonSize * 0.4;
    final double ellipsisPadding = buttonSize * 0.5;

    List<Widget> paginationButtons = [];

    // First Page Button
    paginationButtons.add(
      Padding(
        padding: EdgeInsets.only(right: horizontalPadding),
        child: GestureDetector(
          onTap: currentPage > 1 ? () => onPageChanged(1) : null,
          child: Container(
            height: buttonSize,
            width: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                width: borderWidth,
                color: MyTheme.grey300Color.withOpacity(0.8),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/double_back.png',
                width: iconSize,
                height: iconSize,
              ),
            ),
          ),
        ),
      ),
    );

    // Previous Page Button
    paginationButtons.add(
      GestureDetector(
        onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: borderWidth,
              color: MyTheme.grey300Color.withOpacity(0.8),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios,
              size: iconSize2,
              color: MyTheme.grey300Color,
            ),
          ),
        ),
      ),
    );

    // Page Number Buttons
    int startPage = currentPage > 1 ? currentPage - 1 : currentPage;
    int endPage = (startPage + 2 <= totalPages) ? startPage + 2 : totalPages;

    for (int i = startPage; i <= endPage; i++) {
      paginationButtons.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: GestureDetector(
            onTap: () => onPageChanged(i),
            child: Container(
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                color: i == currentPage
                    ? MyTheme.primary900Color
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  width: borderWidth,
                  color: MyTheme.grey300Color.withOpacity(0.8),
                ),
              ),
              child: Center(
                child: Text(
                  i.toString(),
                  style: TextStyle(
                    color: i == currentPage ? Colors.white : Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Ellipsis and Last Page Button
    if (endPage < totalPages) {
      paginationButtons.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ellipsisPadding),
          child: Text(
            '...',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      paginationButtons.add(
        GestureDetector(
          onTap: () => onPageChanged(totalPages),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                width: borderWidth,
                color: MyTheme.grey300Color.withOpacity(0.8),
              ),
            ),
            child: Center(
              child: Text(
                totalPages.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Next Page Button
    paginationButtons.add(
      GestureDetector(
        onTap: currentPage < totalPages
            ? () => onPageChanged(currentPage + 1)
            : null,
        child: Padding(
          padding: EdgeInsets.only(left: horizontalPadding),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                width: borderWidth,
                color: MyTheme.grey300Color.withOpacity(0.8),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios,
                size: iconSize2,
                color: MyTheme.grey300Color,
              ),
            ),
          ),
        ),
      ),
    );

    // Last Page Button
    paginationButtons.add(
      Padding(
        padding: EdgeInsets.only(left: horizontalPadding),
        child: GestureDetector(
          onTap:
              currentPage < totalPages ? () => onPageChanged(totalPages) : null,
          child: Container(
            height: buttonSize,
            width: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                width: borderWidth,
                color: MyTheme.grey300Color.withOpacity(0.8),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/double_forward.png',
                width: iconSize,
                height: iconSize,
              ),
            ),
          ),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: paginationButtons,
        ),
      ),
    );
  }
}
