class QiDate {
  // ...
  // 实现日期操作的函数
  // ...

  /// 获取本月总天数
  static getMonthDays(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// 获取本月的最后一天
  static getMonthLastDay(int year, int month) {
    return DateTime(year, month + 1, 0);
  }

  /// 获取本月的第一天
  static getMonthFirstDay(int year, int month) {
    return DateTime(year, month, 1);
  }

  /// 获取下个月的第一天
  static getNextMonthFirstDay(int year, int month) {
    return DateTime(year, month + 1, 1);
  }

  /// 获取上个月的第一天
  static getPreviousMonthFirstDay(int year, int month) {
    return DateTime(year, month - 1, 1);
  }

  /// 获取本月第一天的星期数
  static getMonthFirstDayWeekday(int year, int month) {
    return getMonthFirstDay(year, month).weekday;
  }

  /// 获取本月最后一天的星期数
  static getMonthLastDayWeekday(int year, int month) {
    return getMonthLastDay(year, month).weekday;
  }

  /// 获取下个月的第一天星期数
  static getNextMonthFirstDayWeekday(int year, int month) {
    return getNextMonthFirstDay(year, month).weekday;
  }

  /// 获取上个月的第一天星期数
  static getPreviousMonthFirstDayWeekday(int year, int month) {
    return getPreviousMonthFirstDay(year, month).weekday;
  }

  /// 格式化星期
  /// - format<string>：自定义格式化前缀
  /// - digitalWeek<bool>：是否数字星期？
  /// - weekendName<string>: 周末名称
  static String formatWeekday(int weekday, {String? format, bool digitalWeek = false, weekendName = '日'}) {
    String format0 = format ?? '周';
    switch (weekday) {
      case 1:
        return '$format0${digitalWeek ? weekday : '一'}';
      case 2:
        return '$format0${digitalWeek ? weekday : '二'}';
      case 3:
        return '$format0${digitalWeek ? weekday : '三'}';
      case 4:
        return '$format0${digitalWeek ? weekday : '四'}';
      case 5:
        return '$format0${digitalWeek ? weekday : '五'}';
      case 6:
        return '$format0${digitalWeek ? weekday : '六'}';
      case 7:
        return '$format0${digitalWeek ? weekday : weekendName}';
      default:
        return '';
    }
  }
}
