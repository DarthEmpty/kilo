import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/utils.dart';


class SetRow {
  final String name;
  final int reps;
  final double weight;
  final MassUnit unit;
  final Function onDelete;
  TableRow widget;

  SetRow({
    @required this.name,
    @required this.reps,
    @required this.weight,
    @required this.unit,
    this.onDelete,
  }) {
    this.widget = TableRow(
      children: <Widget>[
        Text(this.name),
        Text(this.reps.toString()),
        Text(this.weight.toString() + toMassUnitString(unit)),
        IconButton(
          icon: Icon(FontAwesomeIcons.times),
          onPressed: () => onDelete(this)
        )
      ]
    );
  }

  factory SetRow.fromJson(int index, Map<String, dynamic> json, Function onDelete) {
    return SetRow(
      name: json["name"],
      reps: json["reps"],
      weight: json["weight"],
      unit: toMassUnit(json["unit"]),
      onDelete: onDelete,
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

  SetRow copy() => SetRow(
    name: this.name,
    reps: this.reps,
    weight: this.weight,
    unit: this.unit,
    onDelete: this.onDelete,
  );
}