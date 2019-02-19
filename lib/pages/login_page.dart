import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kilo/blocs/login_bloc.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginBloc _bloc = LoginBloc();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _updateUsername() =>
    this._bloc.dispatch(UpdateUsername(this._usernameController.text));

  void _updatePassword() =>
    this._bloc.dispatch(UpdatePassword(this._passwordController.text));

  Widget _buildForm() => Form(
    key: this._formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Kilo"),

        TextFormField(
         decoration: InputDecoration(labelText: "Username"),
         controller: this._usernameController,
        ),

        TextFormField(
          decoration: InputDecoration(labelText: "Password"),
          obscureText: true,
          controller: this._passwordController,
        ),

        FlatButton(
          onPressed: () => this._bloc.dispatch(Submit(context)),
          child: Text("Login")
        )
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    this._usernameController.addListener(this._updateUsername);
    this._passwordController.addListener(this._updatePassword);
  }

  @override
  void dispose() {
    this._usernameController.dispose();
    this._passwordController.dispose();
    this._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder(
      bloc: this._bloc,
      builder: (BuildContext context, LoginState state) =>
        Center(child: this._buildForm(),)
    )
  );
}