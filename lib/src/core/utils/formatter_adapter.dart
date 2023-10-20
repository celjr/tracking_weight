class FormatterAdapter {
  static String dateFormater(DateTime date) {
    int day = date.day;
    int month = date.month;
    int year = date.year;

    if (day < 10) {
      if (month < 10) {
        return '0$day/0$month/$year';
      } else {
        return '0$day/$month/$year';
      }
    } else {
      return '$day/$month/$year';
    }
  }
}
