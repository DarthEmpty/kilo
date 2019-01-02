import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/utils.dart';


class SetRow extends TableRow {
  final String name;
  final int reps;
  final double weight;
  final MassUnit unit;

  SetRow({
    @required this.name,
    @required this.reps,
    @required this.weight,
    @required this.unit
  }): super(
    children: <Widget>[
      Text(name),
      Text(reps.toString()),
      Text(weight.toString() + toMassUnitString(unit)),
      IconButton(
        icon: Icon(FontAwesomeIcons.times),
        onPressed: null
      )
    ]
  );

  factory SetRow.fromJson(Map<String, dynamic> json) {
    return SetRow(
      name: json["name"],
      reps: json["reps"],
      weight: json["weight"],
      unit: toMassUnit(json["unit"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "reps": this.reps,
      "weight": this.weight,
      "unit": toMassUnitString(this.unit),
    };
  }
}