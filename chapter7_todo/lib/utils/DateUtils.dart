class DateUtils {
  static formatDate(int timestamp) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dt.year}年${dt.month}月${dt.day}日";
  }
}