import 'package:flutter/material.dart';

SizedBox heightWidget(double value) {
  return SizedBox(
    height: value,
  );
}

SizedBox widthWidget(double value) {
  return SizedBox(
    width: value,
  );
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

