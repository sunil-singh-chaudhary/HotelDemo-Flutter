import 'package:flutter/material.dart';

// Define some constants for colors
const kPrimaryColor = Color(0xFF687daf);
const kSecondaryColor = Colors.red;
const kbackgroudColor = Color(0xFFeeedf2);

// Define some constants for text styles
const kTitleTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kgmTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.grey,
  fontWeight: FontWeight.w500,
);
const kheadlineTextStyle = TextStyle(
  fontSize: 26.0,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);
const kheadlineTwoTextStyle = TextStyle(
  fontSize: 24.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

// Define a utility function
String formatName(String firstName, String lastName) {
  return '$firstName $lastName';
}
