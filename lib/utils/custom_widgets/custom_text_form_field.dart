import 'package:flutter/material.dart';
import 'package:kafiil_test/utils/my_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String? tagText;
  Widget? suffixIcon;
  bool isObscure;
  bool? isSuffixIcon;
  TextInputType keyboardType;
  String? Function(String?)? validator;
  TextEditingController? controller;
  double width;
  double height;
  bool hasError;
  int maxLines;
  bool readOnly;
  String? initialValue;

  CustomTextFormField({
    super.key,
    required this.tagText,
    this.suffixIcon,
    this.isSuffixIcon,
    this.isObscure = false,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.width = 334,
    this.height = 56,
    this.hasError = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double adjustedWidth = screenWidth * (width / 375);
    double adjustedHeight = screenHeight * (height / 812);

    double maxWidth = isPortrait ? adjustedWidth : screenWidth * 0.85;
    double minHeight = 56.0;

    double fixedBorderRadius = 16.0;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.012),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$tagText',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize:
                        isPortrait ? screenHeight * 0.017 : screenHeight * 0.05,
                  ),
            ),
            SizedBox(
              height: screenHeight * 0.008,
            ),
            SizedBox(
              width: maxWidth,
              height: adjustedHeight < minHeight ? minHeight : adjustedHeight,
              child: TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                initialValue: initialValue,
                readOnly: readOnly,
                maxLines: maxLines,
                cursorColor: MyTheme.primary900Color,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                      height: 0, fontSize: 0, color: MyTheme.primary900Color),
                  suffixIcon: suffixIcon,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(fixedBorderRadius),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(fixedBorderRadius),
                  ),
                  filled: true,
                  fillColor: MyTheme.grey50Color,
                  contentPadding: EdgeInsets.only(
                      bottom: screenHeight * 0.012,
                      top: screenHeight * 0.025,
                      left: screenWidth * 0.05),
                ),
                style: Theme.of(context).textTheme.titleMedium,
                validator: validator,
                controller: controller,
                obscureText: isObscure,
                keyboardType: keyboardType,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
