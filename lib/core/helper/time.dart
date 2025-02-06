import 'package:flutter/material.dart';

class MyTime {
  static String getFormattedTime(BuildContext context, {required String time}) {
    final result = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(result).format(context);
  }
}
