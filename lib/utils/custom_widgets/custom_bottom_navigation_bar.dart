import 'package:flutter/material.dart';
import 'package:kafiil_test/utils/my_theme.dart';

Widget buildCustomBottomNavigationBar({
  required int selectedIndex,
  required Function(int) onTapFunction,
  required BuildContext context,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  bool isPortrait = screenHeight > screenWidth;

  double iconSize = isPortrait ? screenHeight * 0.035 : screenHeight * 0.085;

  return Material(
    elevation: 8.0,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: BottomNavigationBar(
        selectedLabelStyle: Theme.of(context).textTheme.displaySmall,
        unselectedLabelStyle: Theme.of(context).textTheme.displayLarge,
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyTheme.bgGrey900Color,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onTapFunction,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/icons/${selectedIndex == 0 ? 'selected_user' : 'unselected_user'}.png',
                width: iconSize,
                height: iconSize,
              ),
            ),
            label: "Who Am I",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/icons/${selectedIndex == 1 ? 'selected_globe' : 'unselected_globe'}.png',
                width: iconSize,
                height: iconSize,
              ),
            ),
            label: "Countries",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset(
                'assets/icons/${selectedIndex == 2 ? 'selected_services' : 'unselected_services'}.png',
                width: iconSize,
                height: iconSize,
              ),
            ),
            label: "Services",
          ),
        ],
      ),
    ),
  );
}
