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
        this.onDelete != null ?
          IconButton(
            icon: Icon(FontAwesomeIcons.times),
            onPressed: () => onDelete(this)
          )
          : Container(width: 0, height: 0)
      ]
    );
  }

  factory SetRow.fromJson(Map<String, dynamic> json, Function onDelete) =>
    SetRow(
      name: json["name"] as String,
      reps: json["reps"] as int,
      weight: json["weight"] as double,
      unit: toMassUnit(json["unit"] as String),
      onDelete: onDelete,
    );

  Map<String, dynamic> toJson() => {
    "name": this.name,
    "reps": this.reps,
    "weight": this.weight,
    "unit": toMassUnitString(this.unit),
  };

  SetRow copy() => SetRow(
    name: this.name,
    reps: this.reps,
    weight: this.weight,
    unit: this.unit,
    onDelete: this.onDelete,
  );
}