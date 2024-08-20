import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final bool isLoading;

  const CustomLoadingIndicator({Key? key, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black.withOpacity(0.5),
            ),
          )
        : SizedBox.shrink();
  }
}
