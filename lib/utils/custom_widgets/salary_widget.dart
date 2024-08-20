import 'package:flutter/material.dart';

import '../my_theme.dart';

class SalaryCounter extends StatefulWidget {
  final Function(int) onSalaryChanged;
  final int initialSalary;

  const SalaryCounter({
    Key? key,
    required this.onSalaryChanged,
    this.initialSalary = 100,
  }) : super(key: key);

  @override
  _SalaryCounterState createState() => _SalaryCounterState();
}

class _SalaryCounterState extends State<SalaryCounter> {
  late int salary;

  @override
  void initState() {
    super.initState();
    salary = widget.initialSalary;
  }

  void incrementSalary() {
    setState(() {
      salary += 100;
      if (salary > 1000) {
        salary = 1000;
      }
      widget.onSalaryChanged(salary);
    });
  }

  void decrementSalary() {
    setState(() {
      if (salary > 100) {
        salary -= 100;
        widget.onSalaryChanged(salary);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double containerWidth = isPortrait
        ? screenWidth * 0.9 : screenWidth * 0.7;
    double containerHeight = isPortrait
        ? screenHeight * 0.07 : screenHeight * 0.15;
    double buttonSize = isPortrait
        ? screenHeight * 0.035 : screenHeight * 0.1;
    double iconSize = buttonSize * 0.75;
    double fixedBorderRadius = 16.0;
    double spacing = isPortrait
        ? screenWidth * 0.1 : screenWidth * 0.15;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Salary',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize:
                        isPortrait ? screenHeight * 0.017 : screenHeight * 0.05,
                  )),
          SizedBox(height: screenHeight * 0.01),
          Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              color: MyTheme.grey50Color,
              borderRadius: BorderRadius.circular(fixedBorderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: MyTheme.bgGrey900Color,
                  ),
                  child: InkWell(
                    onTap: decrementSalary,
                    child: Icon(Icons.remove,
                        size: iconSize, color: MyTheme.primary900Color),
                  ),
                ),
                SizedBox(width: spacing),
                Text(
                  'SAR $salary',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: isPortrait
                            ? screenHeight * 0.020
                            : screenHeight * 0.05,
                      ),
                ),
                SizedBox(width: spacing),
                Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: MyTheme.bgGrey900Color,
                  ),
                  child: InkWell(
                    onTap: incrementSalary,
                    child: Icon(Icons.add,
                        size: iconSize, color: MyTheme.primary900Color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
