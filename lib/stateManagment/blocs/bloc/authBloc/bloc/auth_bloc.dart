import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dlivery_app_project/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../../data/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on(registration);
    on(loginUser);
    on(isLoggedin);
    on(removeLocalstorage);
  }

  void registration(RegesterUser event, Emitter emit) async {
    try {
      emit(Loading());
      http.Response response =
          await authRepo.postUser(Constants.registerationURL, event.user);
      if (response.statusCode == 200) {
        await authRepo.loginUser(Constants.loginUrl, event.user);
        emit(SuccessReg(body: 'Account created successfulty!'));
      } else {
        print('err occured in registration from auth bloc: ' + response.body);
        emit(FailedReg(err: 'failed to register try to change your email'));
      }
    } catch (e) {
      print('there is an err in registration method from auth bloc: ' +
          e.toString());
      emit(FailedReg(err: 'failed to registeration!'));
    }
  }

  void loginUser(LoginUser event, Emitter emit) async {
    try {
      emit(Loading());
      http.Response result =
          await authRepo.loginUser(Constants.loginUrl, event.credintial);
      if (result.statusCode == 200) {
        emit(SuccessLogin(body: 'successfuly loged in '));
      } else {
        emit(FailedLogin(err: 'your email or password are wrong!'));
      }
    } catch (e) {
      emit(FailedLogin(err: "failed to log in "));
    }
  }

  void isLoggedin(IsLoggedin event, Emitter emit) {
    bool result = authRepo.isAvailableToken();
    emit(LogginState(isLoggedin: result));
  }

  void removeLocalstorage(RemovelocalStorage event, Emitter emit) {
    authRepo.removeAllLocalStrorage();
    emit(RemoveStorageState());
  }
}
