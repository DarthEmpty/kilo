import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kilo/blocs/login_bloc.dart';
import 'package:kilo/global_state.dart';
import 'package:kilo/pages/home_page.dart';
import 'package:redux/redux.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginBloc _bloc = LoginBloc();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toHome(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage())
  );

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

        BlocBuilder(
          bloc: this._bloc,
          builder: (BuildContext context, LoginState state) =>
            StoreConnector<KiloState, Store<KiloState>> (
              converter: (Store<KiloState> store) => store,
              builder: (BuildContext context, Store<KiloState> store) =>
                FlatButton(
                  child: Text("Login"),
                  onPressed: () => store.dispatch(
                    SubmitCredentials(state.username, state.password)
                  ),
                ),
            )
        ),

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
  Widget build(BuildContext context) => StoreConnector<KiloState, bool>(
    distinct: true,
    converter: (Store<KiloState> store) => store.state.loggedIn,
    builder: (BuildContext context, bool loggedIn) => Scaffold(
      body: BlocBuilder(
        bloc: this._bloc,
        builder: (BuildContext context, LoginState state) =>
          Center(child: this._buildForm()),
      )
    ),
    onWillChange: (bool loggedIn) {
      if (loggedIn) {
        print("***TO HOME***");
        this._toHome(context);
      }
    },
  );
}