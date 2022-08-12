import 'package:flutter/material.dart';

class MySize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double safeWidth;
  static late double safeHeight;
  static late double scaleFactorWidth;
  static late double scaleFactorHeight;

  //Custom sizes
  static late double size0;
  static double? size2;
  static double? size3;
  static double? size4;
  static double? size5;
  static late double size6;
  static double? size7;
  static late double size8;
  static double? size10;
  static double? size12;
  static double? size14;
  static double? size16;
  static double? size18;
  static double? size20;
  static double? size22;
  static double? size24;
  static double? size26;
  static double? size28;
  static double? size30;
  static late double size32;
  static double? size34;
  static double? size36;
  static double? size38;
  static double? size40;
  static double? size42;
  static late double size44;
  static double? size48;
  static double? size50;
  static double? size52;
  static double? size54;
  static late double size56;
  static double? size60;
  static double? size64;
  static double? size68;
  static double? size72;
  static double? size76;
  static double? size80;
  static double? size90;
  static double? size96;
  static double? size100;
  static double? size102;
  static double? size103;
  static double? size104;
  static double? size105;
  static double? size106;
  static double? size107;
  static double? size108;
  static double? size109;
  static double? size110;
  static double? size112;
  static double? size113;

  static double? size114;
  static double? size115;

  static double? size116;
  static double? size118;
  static double? size119;
  static double? size120;
  static double? size140;
  static double? size160;
  static double? size180;

  static double? size200;
  static double? size240;
  static double? size250;
  static double? size300;
  static double? size350;
  static double? size400;
  static double? size450;
  static double? size500;
  static double? size600;
  static double? size700;
  static double? size800;
  static double? size900;
  static double? size1000;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    double _safeAreaWidth =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    double _safeAreaHeight =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeWidth = (screenWidth - _safeAreaWidth);
    safeHeight = (screenHeight - _safeAreaHeight);

    //Scale factor for responsive UI
    scaleFactorHeight = (safeHeight / 820);
    if (scaleFactorHeight < 1) {
      double diff = (1 - scaleFactorHeight) * (1 - scaleFactorHeight);
      scaleFactorHeight += diff;
    }
    scaleFactorWidth = safeWidth / 392;
    if (scaleFactorWidth < 1) {
      double diff = (1 - scaleFactorWidth) * (1 - scaleFactorWidth);
      scaleFactorWidth += diff;
    }

    //Custom sizes
    size0 = 0;
    size2 = scaleFactorHeight * 2;
    size3 = scaleFactorHeight * 3;
    size4 = scaleFactorHeight * 4;
    size5 = scaleFactorHeight * 5;
    size6 = scaleFactorHeight * 6;
    size7 = scaleFactorHeight * 7;
    size8 = scaleFactorHeight * 8;
    size10 = scaleFactorHeight * 10;
    size12 = scaleFactorHeight * 12;
    size14 = scaleFactorHeight * 14;
    size16 = scaleFactorHeight * 16;
    size18 = scaleFactorHeight * 18;
    size20 = scaleFactorHeight * 20;
    size22 = scaleFactorHeight * 22;
    size24 = scaleFactorHeight * 24;
    size26 = scaleFactorHeight * 26;
    size28 = scaleFactorHeight * 28;
    size30 = scaleFactorHeight * 30;
    size32 = scaleFactorHeight * 32;
    size34 = scaleFactorHeight * 34;
    size36 = scaleFactorHeight * 36;
    size38 = scaleFactorHeight * 38;
    size40 = scaleFactorHeight * 40;
    size42 = scaleFactorHeight * 42;
    size44 = scaleFactorHeight * 44;
    size48 = scaleFactorHeight * 48;
    size50 = scaleFactorHeight * 50;
    size52 = scaleFactorHeight * 52;
    size54 = scaleFactorHeight * 54;
    size56 = scaleFactorHeight * 56;
    size60 = scaleFactorHeight * 60;
    size64 = scaleFactorHeight * 64;
    size68 = scaleFactorHeight * 68;
    size72 = scaleFactorHeight * 72;
    size76 = scaleFactorHeight * 76;
    size80 = scaleFactorHeight * 80;
    size90 = scaleFactorHeight * 90;
    size96 = scaleFactorHeight * 96;
    size100 = scaleFactorHeight * 100;
    size102 = scaleFactorHeight * 102;
    size103 = scaleFactorHeight * 103;
    size104 = scaleFactorHeight * 104;
    size105 = scaleFactorHeight * 105;
    size106 = scaleFactorHeight * 106;
    size107 = scaleFactorHeight * 107;
    size108 = scaleFactorHeight * 108;
    size109 = scaleFactorHeight * 109;
    size110 = scaleFactorHeight * 110;
    size112 = scaleFactorHeight * 112;
    size113 = scaleFactorHeight * 113;
    size114 = scaleFactorHeight * 114;
    size115 = scaleFactorHeight * 115;
    size116 = scaleFactorHeight * 116;
    size118 = scaleFactorHeight * 118;
    size119 = scaleFactorHeight * 119;

    size120 = scaleFactorHeight * 120;
    size140 = scaleFactorHeight * 140;
    size160 = scaleFactorHeight * 160;
    size180 = scaleFactorHeight * 180;

    size200 = scaleFactorHeight * 200;
    size240 = scaleFactorHeight * 240;
    size250 = scaleFactorHeight * 250;

    size300 = scaleFactorHeight * 300;
    size350 = scaleFactorHeight * 350;
    size400 = scaleFactorHeight * 400;
    size450 = scaleFactorHeight * 450;

    size500 = scaleFactorHeight * 500;
    size600 = scaleFactorHeight * 600;
    size700 = scaleFactorHeight * 700;

    size800 = scaleFactorHeight * 800;
    size900 = scaleFactorHeight * 900;
    size1000 = scaleFactorHeight * 1000;
  }

  static double getScaledSizeWidth(double size) {
    return (size * scaleFactorWidth);
  }

  static double getScaledSizeHeight(double size) {
    return (size * scaleFactorHeight);
  }
}

class Spacing {
  static EdgeInsetsGeometry zero = EdgeInsets.zero;

  static EdgeInsetsGeometry only(
      {double top = 0,
      double right = 0,
      double bottom = 0,
      double left = 0,
      bool withResponsive = true}) {
    if (withResponsive) {
      return EdgeInsets.only(
          left: MySize.getScaledSizeHeight(left),
          right: MySize.getScaledSizeHeight(right),
          top: MySize.getScaledSizeHeight(top),
          bottom: MySize.getScaledSizeHeight(bottom));
    } else {
      return EdgeInsets.only(
          left: left, right: right, top: top, bottom: bottom);
    }
  }

  static EdgeInsetsGeometry fromLTRB(
      double left, double top, double right, double bottom,
      {bool withResponsive = true}) {
    return Spacing.only(
        bottom: bottom,
        top: top,
        right: right,
        left: left,
        withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry all(double spacing, {bool withResponsive = true}) {
    return Spacing.only(
        bottom: spacing,
        top: spacing,
        right: spacing,
        left: spacing,
        withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry left(double spacing, {bool withResponsive = true}) {
    return Spacing.only(left: spacing, withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry top(double spacing, {bool withResponsive = true}) {
    return Spacing.only(top: spacing, withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry right(double spacing,
      {bool withResponsive = true}) {
    return Spacing.only(right: spacing, withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry bottom(double spacing,
      {bool withResponsive = true}) {
    return Spacing.only(bottom: spacing, withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry horizontal(double spacing,
      {bool withResponsive = true}) {
    return Spacing.only(
        left: spacing, right: spacing, withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry vertical(double spacing,
      {bool withResponsive = true}) {
    return Spacing.only(
        top: spacing, bottom: spacing, withResponsive: withResponsive);
  }

  static EdgeInsetsGeometry symmetric(
      {double vertical = 0,
      double horizontal = 0,
      bool withResponsive = true}) {
    return Spacing.only(
        top: vertical,
        right: horizontal,
        left: horizontal,
        bottom: vertical,
        withResponsive: withResponsive);
  }
}