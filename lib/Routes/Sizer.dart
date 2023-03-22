import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sizer {
  static getsize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static getscreenHeight() {
    return Get.height;
  }

  static getscreenWidth() {
    return Get.width;
  }

  static getcalculateHeight(double pixel) {
    double x = getscreenHeight() / pixel;

    return getscreenHeight() / x;
  }

  static getCalulateWidth(double pixel) {
    double y = getscreenWidth() / pixel;

    return getscreenWidth() / y;
  }
}
