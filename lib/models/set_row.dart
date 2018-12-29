import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/utils.dart';



class SetRow extends TableRow {
  final String setName;
  final int reps;
  final double weight;
  final MassUnit unit;

  SetRow({
    @required this.setName,
    @required this.reps,
    @required this.weight,
    @required this.unit
  }): super(
    children: <Widget>[
      Text(setName),
      Text(reps.toString()),
      Text(weight.toString() + toMassUnitString(unit)),
      IconButton(
        icon: Icon(FontAwesomeIcons.times),
        onPressed: null
      )
    ]
  );
}