part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class RegesterUser extends AuthEvent {
  final String user;
  RegesterUser({required this.user});
  @override
  List<Object> get props => [user];
}

class LoginUser extends AuthEvent {
  final String credintial;
  LoginUser({required this.credintial});
  @override
  List<Object?> get props => [credintial];
}

class IsLoggedin extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class RemovelocalStorage extends AuthEvent {
  @override
  List<Object?> get props => [];
}
