import 'package:flutter/material.dart';

import '../../domain/entities/ServicesDataEntity.dart';
import '../my_theme.dart';

class LogoCard extends StatelessWidget {
  final ServiceDataEntity service;
  final double screenWidth;
  final double screenHeight;
  final bool isPortrait;

  const LogoCard({
    super.key,
    required this.service,
    required this.screenWidth,
    required this.screenHeight,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.02,
          bottom: screenHeight * 0.01,
          top: screenHeight * 0.005),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
          color: MyTheme.bgGrey900Color,
        ),
        width: isPortrait ? screenWidth * 0.4 : screenWidth * 0.25,
        height: isPortrait ? screenHeight * 0.25 : screenHeight * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    child: Image.network(
                      service.mainImage ?? '',
                      width: screenWidth * 0.38,
                      height: isPortrait
                          ? screenHeight * 0.14
                          : screenHeight * 0.23,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom:
                      isPortrait ? screenHeight * 0.02 : screenHeight * 0.03,
                  left: screenWidth * 0.03,
                  child: IntrinsicWidth(
                    child: Container(
                      height: isPortrait
                          ? screenHeight * 0.03
                          : screenHeight * 0.05,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.005),
                      decoration: BoxDecoration(
                        color: MyTheme.primary900Color,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Text(
                        '\$${service.priceAfterDiscount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isPortrait
                              ? screenHeight * 0.016
                              : screenHeight * 0.03,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.03),
              child: SizedBox(
                height: isPortrait ? screenHeight * 0.05 : screenHeight * 0.12,
                child: Text(
                  service.title ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: isPortrait
                        ? screenHeight * 0.016
                        : screenHeight * 0.038,
                    fontWeight: FontWeight.w500,
                    color: MyTheme.grey900Color,
                  ),
                ),
              ),
            ),
            SizedBox(
                height: isPortrait ? screenHeight * 0.01 : screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      isPortrait ? screenWidth * 0.03 : screenWidth * 0.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                        width: isPortrait
                            ? screenWidth * 0.08
                            : screenWidth * 0.055),
                    Image.asset(
                      'assets/icons/Star.png',
                      width: isPortrait
                          ? screenWidth * 0.035
                          : screenWidth * 0.025,
                      height: isPortrait
                          ? screenHeight * 0.02
                          : screenWidth * 0.025,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      '(${service.averageRating})',
                      style: TextStyle(
                        fontSize: isPortrait
                            ? screenHeight * 0.015
                            : screenHeight * 0.035,
                        color: const Color(0xffFFCB31),
                      ),
                    ),
                    SizedBox(
                      height: isPortrait
                          ? screenHeight * 0.02
                          : screenHeight * 0.05,
                      child: VerticalDivider(
                        color: MyTheme.grey300Color,
                        thickness: screenWidth * 0.003,
                      ),
                    ),
                    Image.asset(
                      'assets/icons/cart.png',
                      width:
                          isPortrait ? screenWidth * 0.04 : screenWidth * 0.05,
                      height: isPortrait
                          ? screenHeight * 0.02
                          : screenWidth * 0.025,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      '${service.completedSalesCount}',
                      style: TextStyle(
                        fontSize: isPortrait
                            ? screenHeight * 0.015
                            : screenHeight * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
