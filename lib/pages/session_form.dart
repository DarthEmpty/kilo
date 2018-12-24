import 'package:flutter/material.dart';


class SessionForm extends StatefulWidget {
  final String title = "Session Form";

  @override
  _SessionFormState createState() => _SessionFormState();
}

class _SessionFormState extends State<SessionForm> {
  final _formKey = GlobalKey<FormState>();

  void _toHome(BuildContext context) => Navigator.pop(context);

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
                hintText: "What muscle groups are you focussing on today?",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter some text";
                }
              },
            ),
            FlatButton(
              child: Text("Submit"),
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
