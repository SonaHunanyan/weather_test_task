import 'package:flutter/cupertino.dart';

// Iphone 14
const int relativeWidth = 390;
const int relativeHeight = 844;

double rw(BuildContext context) {
  return rwWidth(MediaQuery.of(context).size.width);
}

double rh(BuildContext context) {
  return rwHeight(MediaQuery.of(context).size.height);
}

double rwHeight(double height) {
  return height / relativeHeight;
}

double rwWidth(double width) {
  return width / relativeWidth;
}
