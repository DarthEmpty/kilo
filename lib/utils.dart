import 'package:date_format/date_format.dart';


String toDateString(DateTime datetime) {
  return formatDate(datetime, [dd, "/", mm, "/", yy]);
}


enum MassUnit {KG, LB}
String toMassUnitString(MassUnit unit) {
  switch (unit) {
    case MassUnit.KG:
      return "kg";
    case MassUnit.LB:
      return "lbs";
    default:
      return "";
  }
}