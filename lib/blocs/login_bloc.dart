import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kilo/models/http_client.dart';
import 'package:kilo/pages/home_page.dart';
import 'package:kilo/utils.dart';


class LoginState {
  final String username;
  final String password;
  
  LoginState({
    @required this.username,
    @required this.password,
  });
  
  factory LoginState.initial() => LoginState(
    username: "",
    password: "",
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
      );
    }

    else if (event is UpdatePassword) {
      yield LoginState(
        username: currentState.username,
        password: event.newValue,
      );
    }
  }
}
