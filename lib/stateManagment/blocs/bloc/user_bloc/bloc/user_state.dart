part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class GetUserInfoState extends UserState {
  UserModel userDatas;
  GetUserInfoState({required this.userDatas});
  @override
  List<Object> get props => [userDatas];
}

final class ExpiredTokenState extends UserState {}
