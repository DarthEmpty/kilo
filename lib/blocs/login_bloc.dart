import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kilo/models/http_client.dart';
import 'package:kilo/pages/home_page.dart';
import 'package:kilo/utils.dart';


class LoginState {
  final String username;
  final String password;
  final bool success;
  
  LoginState({
    @required this.username,
    @required this.password,
    @required this.success,
  });
  
  factory LoginState.initial() => LoginState(
    username: "",
    password: "",
    success: false,
  );
}

// region Events
abstract class LoginEvent {}

class UpdateUsername extends LoginEvent {
  final String newValue;
  UpdateUsername(this.newValue);
}

class UpdatePassword extends LoginEvent {
  final String newValue;
  UpdatePassword(this.newValue);
}

class Submit extends LoginEvent {
  final BuildContext context;
  Submit(this.context);
}
// endregion

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginState currentState, LoginEvent event) async* {
    if (event is UpdateUsername) {
      yield LoginState(
        username: event.newValue,
        password: currentState.password,
        success: currentState.success,
      );
    }

    else if (event is UpdatePassword) {
      yield LoginState(
        username: currentState.username,
        password: event.newValue,
        success: currentState.success,
      );
    }
    
    else if (event is Submit) {
      HTTPClient client = HTTPClient(
        kiloServerIP,
        username: currentState.username,
        password: currentState.password,
      );


      if (await client.head("accounts/${currentState.username}") == 200) {
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => HomePage())
        );

        yield LoginState(
          username: currentState.username,
          password: currentState.password,
          success: true,
        );
      }
    }
  }

}
