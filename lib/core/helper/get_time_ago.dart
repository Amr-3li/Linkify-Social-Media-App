import 'package:timeago/timeago.dart' as timeago;

class GetTimeAgo {
  static String getTimeAgo(String timeString) {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(timeString));
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    return timeago.format(now.subtract(difference));
  }
}
