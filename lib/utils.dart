import 'package:date_format/date_format.dart';


String toDateString(DateTime datetime) {
  return formatDate(datetime, [dd, "/", mm, "/", yy]);
}