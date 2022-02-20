import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key? key,
    this.containerHeight = 50.0,
    this.borderRadius = 8.0,
    required this.tabLabel,
    this.fontSize = 16.0,
    required this.isSelectedTab,
  }) : super(key: key);

  final double containerHeight;
  final double borderRadius;
  final String tabLabel;
  final double fontSize;
  final bool isSelectedTab;

  @override
  Widget build(BuildContext context) {
    return isSelectedTab
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: containerHeight,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 50,
                  color: kBlack.withOpacity(0.5),
                )
              ],
            ),
            child: Center(
              child: Text(
                tabLabel,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: kPrimaryColor.withOpacity(0.6),
                  fontSize: fontSize,
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 50,
                  color: kBlack.withOpacity(0.1),
                )
              ],
            ),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: kWhite.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Center(
                    child: Text(
                      tabLabel,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: kBlack.withOpacity(0.6),
                        fontSize: fontSize,
                        fontFamily: 'Roboto-Regular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
