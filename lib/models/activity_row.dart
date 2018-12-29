import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/utils.dart';



class ActivityRow extends TableRow {
  final String activity;
  final int reps;
  final double weight;
  final MassUnit unit;

  ActivityRow({
    @required this.activity,
    @required this.reps,
    @required this.weight,
    @required this.unit
  }): super(
    children: <Widget>[
      Text(activity),
      Text(reps.toString()),
      Text(weight.toString() + toMassUnitString(unit)),
      IconButton(
        icon: Icon(FontAwesomeIcons.times),
        onPressed: null
      )
    ]
  );
}