mergeDateTime(DateTime? dateTime, String hourTime) {
  final splitDate = dateTime!.toIso8601String().substring(0, 10);
  DateTime dt = DateTime.parse('${splitDate} ${hourTime}');
  var tgl = dt.day;
  var month = dt.month;
  var year = dt.year;
  var hour = dt.hour;
  var minutes = dt.minute;
  final time = DateTime(year, month, tgl, hour, minutes);
  return time;
}
