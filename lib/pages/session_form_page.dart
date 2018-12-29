import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/blocs/session_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kilo/utils.dart';
import 'package:kilo/models/activity_row.dart';


class SessionFormPage extends StatefulWidget {
  final String title = "Session Form";

  @override
  _SessionFormPageState createState() => _SessionFormPageState();
}

class _SessionFormPageState extends State<SessionFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SessionFormBloc _bloc = SessionFormBloc();
  final TextEditingController _titleController = TextEditingController();

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

          Text(toDateString(state.date)),
          IconButton(
            icon: Icon(FontAwesomeIcons.calendarAlt),
            onPressed: () => this._chooseDate(state),
          ),

          Table(
            children: <TableRow>[
              ActivityRow(
                activity: "Farmer's Walk",
                reps: 5,
                weight: 30,
                unit: MassUnit.KG,
              ),

              ActivityRow(
                activity: "Squats",
                reps: 8,
                weight: 10.2,
                unit: MassUnit.LB,
              ),

              ActivityRow(
                activity: "Deadlifts",
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
