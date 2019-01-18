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
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  void _toHome(BuildContext context) => Navigator.pop(context);

  void _updateTitle() =>
    this._bloc.dispatch(UpdateTitle(this._titleController.text));

  void _addRow() => this._bloc.dispatch(AddToTable());

  void _removeRow(SetRow row) => this._bloc.dispatch(RemoveFromTable(row));

  void _updateNewSetRow({MassUnit unit}) =>
    this._bloc.dispatch(UpdateNewSetRow(SetRow(
      name: this._setNameController.text,
      reps: int.parse(this._repsController.text),
      weight: double.parse(this._weightController.text),
      unit: unit ?? this._bloc.currentState.newSetRow.unit,
      onDelete: (SetRow row) => this._removeRow(row),
    )));

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
                value: state.newSetRow.unit,
                onChanged: (MassUnit value) => this._updateNewSetRow(unit: value),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.plus),
                onPressed: this._addRow,
              ),
            ],
          ),

          Table(children: state.tableRows.map((row) => row.widget).toList()),

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
    this._setNameController.addListener(this._updateNewSetRow);
    this._repsController.addListener(this._updateNewSetRow);
    this._weightController.addListener(this._updateNewSetRow);
  }

  @override
  void dispose() {
    this._titleController.dispose();
    this._setNameController.dispose();
    this._repsController.dispose();
    this._weightController.dispose();
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
