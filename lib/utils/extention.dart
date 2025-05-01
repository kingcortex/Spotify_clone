import 'package:flutter/material.dart';

extension IntExtention on int {
  SizedBox get verticalSpace => SizedBox(height: toDouble());
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}


extension DurationExtention on Duration {
  bool isAfter(DateTime dt) {
    return this > dt.difference(DateTime(1970, 1, 1));
  }
}
