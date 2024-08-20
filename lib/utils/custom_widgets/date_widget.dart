import 'package:flutter/material.dart';
import 'package:kafiil_test/utils/my_theme.dart';

class DateWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DateWidget({super.key, required this.onDateSelected});

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime selectedDate = DateTime(2000, 01, 01);

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
      widget.onDateSelected(selectedDate);
    }
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
    double iconScale = isPortrait ? 2.7 : 2.5;
    double fixedBorderRadius = 16.0;
    double paddingHorizontal = isPortrait
        ? screenWidth * 0.05 : screenWidth * 0.03;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Birth Date',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize:
                        isPortrait ? screenHeight * 0.017 : screenHeight * 0.05,
                  ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: MyTheme.grey50Color,
                borderRadius: BorderRadius.circular(fixedBorderRadius),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: paddingHorizontal),
                    child: Text(
                      '${selectedDate.toLocal()}'.split(' ')[0],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: isPortrait
                                ? screenHeight * 0.017
                                : screenHeight * 0.05,
                          ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: paddingHorizontal),
                    child: GestureDetector(
                      onTap: showCalendar,
                      child: Image.asset(
                        'assets/icons/calender.png',
                        scale: iconScale,
                      ),
                    ),
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
