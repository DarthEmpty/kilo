import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/blocs/session_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kilo/utils.dart';
import 'package:kilo/models/set_row.dart';


class SessionFormPage extends StatefulWidget {
  final String title = "Session Form";

  @override
  _SessionFormPageState createState() => _SessionFormPageState();
}

class _SessionFormPageState extends State<SessionFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SessionFormBloc _bloc = SessionFormBloc();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _setNameController = TextEditingController();
  final TextEditingController _repsController = TextEditingController(text: "0");
  final TextEditingController _weightController = TextEditingController(text: "0.0");

  void _toHome(BuildContext context) => Navigator.pop(context);

  void _updateTitle() =>
    this._bloc.dispatch(UpdateTitle(this._titleController.value.toString()));

  Future _chooseDate(SessionFormState state) async {
    DateTime now = DateTime.now();
    DateTime newDate = await showDatePicker(
      context: context,
      initialDate: state.date,
      firstDate: now.subtract(Duration(days: 365)),
      lastDate: now
    );

    if (newDate != null) {
      this._bloc.dispatch(UpdateDate(newDate));
    }
  }

  Form _buildForm(SessionFormState state) {
    return Form(
      key: this._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          TextFormField(
            decoration: InputDecoration(labelText: "Title",),
            controller: this._titleController,
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter some text";
              }
            },
          ),

          Row(
            children: <Widget>[
              Text(toDateString(state.date)),
              IconButton(
                icon: Icon(FontAwesomeIcons.calendarAlt),
                onPressed: () => this._chooseDate(state),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(child: TextFormField(
                decoration: InputDecoration(labelText: "Set Name"),
                controller: this._setNameController,
              )),
              Expanded(child: TextFormField(
                decoration: InputDecoration(labelText: "Reps"),
                keyboardType: TextInputType.number,
                controller: this._repsController,
              )),
              Expanded(child: TextFormField(
                decoration: InputDecoration(labelText: "Weight"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: this._weightController,
              )),
              DropdownButton<MassUnit>(
                items: MassUnit.values.map(
                  (value) => DropdownMenuItem<MassUnit>(
                    value: value,
                    child: Text(toMassUnitString(value)),
                  )
                ).toList(),
                value: state.unit,
                onChanged: (MassUnit value) =>
                    this._bloc.dispatch(UpdateUnit(value)),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.plus),
                onPressed: () {},
              ),
            ],
          ),

          Table(
            children: <TableRow>[
              SetRow(
                name: "Farmer's Walk",
                reps: 5,
                weight: 30,
                unit: MassUnit.KG,
              ),
              SetRow(
                name: "Squats",
                reps: 8,
                weight: 10.2,
                unit: MassUnit.LB,
              ),
              SetRow(
                name: "Deadlifts",
                reps: 8,
                weight: 30,
                unit: MassUnit.KG,
              ),
            ]
          ),

          IconButton(
            icon: Icon(FontAwesomeIcons.check),
            onPressed: () {
              if (this._formKey.currentState.validate()) {
                this._toHome(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this._titleController.addListener(this._updateTitle);
  }

  @override
  void dispose() {
    this._titleController.dispose();
    this._setNameController.dispose();
    this._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        automaticallyImplyLeading: false,
      ),

      body: BlocBuilder(
        bloc: this._bloc,
        builder: (BuildContext context, SessionFormState state) =>
          this._buildForm(state)
      )
    );
  }
}
