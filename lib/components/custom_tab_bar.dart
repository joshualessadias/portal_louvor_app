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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: containerHeight,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 30,
            color: isSelectedTab
                ? kBlack.withOpacity(0.5)
                : kBlack.withOpacity(0.0),
          )
        ],
      ),
      child: Center(
        child: Text(
          tabLabel,
          style: TextStyle(
            decoration: TextDecoration.none,
            color: isSelectedTab
                ? kPrimaryColor.withOpacity(0.6)
                : kBlack.withOpacity(0.6),
            fontSize: fontSize,
            fontFamily: 'Roboto-Regular',
            fontWeight: isSelectedTab ? FontWeight.bold : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
