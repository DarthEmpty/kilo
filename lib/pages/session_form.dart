import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/utils.dart';


class SessionForm extends StatefulWidget {
  final String title = "Session Form";

  @override
  _SessionFormState createState() => _SessionFormState();
}

class _SessionFormState extends State<SessionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _dateString = toDateString(DateTime.now());

  void _toHome(BuildContext context) => Navigator.pop(context);

  Future _chooseDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now()
    );

    if (date != null) {
      setState(() => this._dateString = toDateString(date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        automaticallyImplyLeading: false,
      ),

      body: Form(
        key: this._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter some text";
                }
              },
            ),
            Text(this._dateString),
            IconButton(
                icon: Icon(FontAwesomeIcons.calendarAlt),
                onPressed: _chooseDate,
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
      )
    );
  }
}
