part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class SuccessReg extends AuthState {
  final String body;
  SuccessReg({required this.body});
  @override
  List<Object> get props => [body];
}

class FailedReg extends AuthState {
  final String err;
  FailedReg({required this.err});
  @override
  List<Object> get props => [err];
}

class Loading extends AuthState {}

// login user states
class FailedLogin extends AuthState {
  final String err;
  FailedLogin({required this.err});
  @override
  List<Object> get props => [err];
}

class SuccessLogin extends AuthState {
  final String body;
  SuccessLogin({required this.body});
  @override
  List<Object> get props => [body];
}

class LogginState extends AuthState {
  final bool isLoggedin;
  LogginState({required this.isLoggedin});
  @override
  List<Object> get props => [isLoggedin];
}

class RemoveStorageState extends AuthState {
  @override
  List<Object> get props => [];
}
