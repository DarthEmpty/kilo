import 'package:date_format/date_format.dart';


enum MassUnit {KG, LB}

String toDateString(DateTime datetime) => formatDate(datetime, [dd, "/", mm, "/", yy]);

String toMassUnitString(MassUnit unit) => unit.toString().split("\.")[1].toLowerCase();

MassUnit toMassUnit(String string) => MassUnit.values.firstWhere((value) => toMassUnitString(value) == string);